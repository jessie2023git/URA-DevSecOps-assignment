
#Terraform backend resources 

# Module to retrieve VPC information
#TODO: Check the currect subnet_ids to be returned for each resources (e.g: ALB, VPCE, ECS and service definition)
module "vpc_info" {
  source = "../modules/vpc_info"
  vpc_id = var.vpc_id
  filter_value = [var.env == "dev" ? "DL_GRAF_DEV_VPC-PRIVATE" : "DL_GRAF_PROD_VPC-PRIVATE"]
}

# KMS Key Module
#module "ecr_kms_key" {
#  source    = "../modules/kms"
#  tags      =  {
#    Name    = "ecr-kms-key-${var.env}",
#    Project = var.proj,
#    Environment = var.env
#  }  
#}

# ECR Repository Module with Encryption Configuration
#module "ecr" {
#  source         = "../modules/ecr"
#  name           = "application-${var.env}-repository"
#  kms_key        = module.ecr_kms_key.kms_key_id
#  tags           =  {
#    Project      = var.proj,
#    Environment  = var.env
#  }    
#}

# Security Group for ECS Service
module "security_group_ecs_service" {
  source        = "../modules/security_group"
  name          = "application-${var.env}-sg-ecs-service"
  description   = "Security Group for ECS Service"
  vpc_id        = module.vpc_info.vpc_id  

  ingress_rules = [{
      from_port    = 2049
      to_port      = 2049
      protocol     = "tcp"
      source_security_group_id   = module.ecr_security_group_efs.security_group_id
  },
  {
        from_port    = 3000
        to_port      = 3000
        protocol     = "tcp"
        source_security_group_id   = module.ecr_security_group_alb.security_group_id
  },
  {
        from_port    = 0
        to_port      = 0
        protocol     = "-1"
        source_security_group_id   = module.ecr_security_group_api.security_group_id
  }      
  ]

  egress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr         = ["0.0.0.0/0"]
  },
  {
      from_port    = 2049
      to_port      = 2049
      protocol     = "tcp"
      source_security_group_id   = module.ecr_security_group_efs.security_group_id
  },
  {
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      source_security_group_id   = module.security_group_cloudwatch_service.security_group_id
  },
  {
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      source_security_group_id   = module.ecr_security_group_api.security_group_id
  },
  {
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      prefix_list_ids   = [var.env == "dev" ? module.ecr_vpc_endpoint_s3[0].s3_prefix_list_id : var.prefix_list_ids]      
      #prefix_list_ids   = [module.ecr_vpc_endpoint_s3.aws_vpc_endpoint.ecr_vpc_endpoint_gateway.prefix_list_id]
  }
  ]

  tags          = {
    Name        = "application-${var.env}-sg-ecs-service",
    Project     = var.proj,
    Environment = var.env
  }
}

# Security Group for ECS Service
module "security_group_cloudwatch_service" {
  source        = "../modules/security_group"
  name          = "application-${var.env}-sg-cloudwatch-service"
  description   = "Security Group for ECS Service"
  vpc_id        = module.vpc_info.vpc_id  

  ingress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr         = [module.vpc_info.vpc_cidr_block]
  }]

  tags          = {
    Name        = "application-${var.env}-sg-cloudwatch-service",
    Project     = var.proj,
    Environment = var.env
  }
}

# Security Group for ECR DKR
module "ecr_security_group_dkr" {
  source        = "../modules/security_group"
  name          = "application-${var.env}-sg-ecr-dkr"
  description   = "Security Group for ECR DKR"
  vpc_id        = module.vpc_info.vpc_id

  ingress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr         = [module.vpc_info.vpc_cidr_block]
  }]

  egress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      source_security_group_id   = module.security_group_ecs_service.security_group_id
  }]

  tags          = {
    Name        = "application-${var.env}-sg-ecr-dkr",
    Project     = var.proj,
    Environment = var.env
  }
}

# Security Group for ECR API
module "ecr_security_group_api" {
  source        = "../modules/security_group"
  name          = "application-${var.env}-sg-ecr-api"
  description   = "Security Group for ECR API"
  vpc_id        = module.vpc_info.vpc_id  

  ingress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr         = [module.vpc_info.vpc_cidr_block]
  }]

  egress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      source_security_group_id   = module.security_group_ecs_service.security_group_id
  }]

  tags          = {
    Name        = "application-${var.env}-sg-ecr-api",
    Project     = var.proj,
    Environment = var.env
  }  
}


# VPC Endpoint Modules
# VPCE for ECR Docker flow
module "ecr_vpc_endpoint_dkr" {
  is_vpce_gw         = 0
  source             = "../modules/vpc_endpoint"
  vpc_id             = module.vpc_info.vpc_id
  service_name       = "com.amazonaws.ap-southeast-1.ecr.dkr"
  subnet_ids         = module.vpc_info.subnet_ids
  security_group_ids = [module.ecr_security_group_dkr.security_group_id]
  tags          = {
    Name        = "ecr-${var.env}-vpce-ecr-dkr",
    Project     = var.proj,
    Environment = var.env
  } 
}

# VPCE for ECR API flow
module "ecr_vpc_endpoint_api" {
  is_vpce_gw         = 0
  source             = "../modules/vpc_endpoint"
  vpc_id             = module.vpc_info.vpc_id
  service_name       = "com.amazonaws.ap-southeast-1.ecr.api"
  subnet_ids         = module.vpc_info.subnet_ids
  security_group_ids = [module.ecr_security_group_api.security_group_id]
  tags          = {
    Name        = "ecr-${var.env}-vpce-ecr-api",
    Project     = var.proj,
    Environment = var.env
  } 
}

# VPCE for Cloudwatch logging
module "cloudwatch_vpc_endpoint" {
  is_vpce_gw         = 0
  source             = "../modules/vpc_endpoint"
  vpc_id             = module.vpc_info.vpc_id
  service_name       = "com.amazonaws.ap-southeast-1.logs"
  subnet_ids         = module.vpc_info.subnet_ids
  security_group_ids = [module.security_group_cloudwatch_service.security_group_id]
  tags          = {
    Name        = "cloudwatch-${var.env}-vpce-ecr",
    Project     = var.proj,
    Environment = var.env
  } 
}

# VPCE for S3 image access
module "ecr_vpc_endpoint_s3" {
  count = var.env == "dev" ? 1 : 0 # only create this on dev as its already existing in prod
  is_vpce_gw         = 1
  source             = "../modules/vpc_endpoint"
  vpc_id             = module.vpc_info.vpc_id
  service_name       = "com.amazonaws.ap-southeast-1.s3"
  subnet_ids         = module.vpc_info.subnet_ids

  tags          = {
    Name        = "s3-${var.env}-vpce-ecr",
    Project     = var.proj,
    Environment = var.env
  } 
}

# Security Group for EFS - S3 token sync
module "security_group_application_datasync" {
  source        = "../modules/security_group"
  name          = "application-${var.env}-sg-datasync"
  description   = "Single use SG to sync EFS and S3"
  vpc_id        = module.vpc_info.vpc_id  


  egress_rules = [{
      from_port                 = 443
      to_port                   = 443
      protocol                  = "tcp"
      prefix_list_ids   = [var.env == "dev" ? module.ecr_vpc_endpoint_s3[0].s3_prefix_list_id : var.prefix_list_ids]
      #prefix_list_ids   = [module.ecr_vpc_endpoint_s3.aws_vpc_endpoint.ecr_vpc_endpoint_gateway.prefix_list_id]
  },
  {
      from_port                 = 2049
      to_port                   = 2049
      protocol                  = "tcp"
      source_security_group_id  = module.ecr_security_group_efs.security_group_id
  }]

  tags          = {
    Name        = "application-${var.env}-sg-datasync",
    Project     = var.proj,
    Environment = var.env
  }
}

# Security Group for EFS mount target
module "ecr_security_group_efs" {
  source        = "../modules/security_group"
  name          = "application-${var.env}-sg-efs-mount-target"
  description   = "Security Group for EFS mount target"
  vpc_id        = module.vpc_info.vpc_id  

  ingress_rules = [{
      from_port    = 2049
      to_port      = 2049
      protocol     = "tcp"
      source_security_group_id         = module.security_group_ecs_service.security_group_id
  },{
      from_port    = 2049
      to_port      = 2049
      protocol     = "tcp"
      source_security_group_id         = module.security_group_application_datasync.security_group_id
  }]

  egress_rules = [{
      from_port    = 2049
      to_port      = 2049
      protocol     = "tcp"
      source_security_group_id         = module.security_group_ecs_service.security_group_id
  }]

  tags          = {
    Name        = "application-${var.env}-sg-efs-mount-target",
    Project     = var.proj,
    Environment = var.env
  }
}

# Create EFS to store application configuration
module "efs" {
  source              = "../modules/efs"
  efs_name            = "application-${var.env}-efs"
  subnet_ids          = module.vpc_info.subnet_ids
  security_group_ids  = [module.ecr_security_group_efs.security_group_id]
  performance_mode    = "generalPurpose"
  throughput_mode     = "bursting"
  enable_encryption   = true
  tags                = {
    Name              = "application-${var.env}-efs",
    Project           = var.proj,
    Environment       = var.env
  }  
}


# Create ECS fargate cluster
module "ecs" {
  source             = "../modules/ecs"
  cluster_name       = "application-${var.env}-app"

  tags               = {
    Name             = "application-${var.env}-app",
    Project          = var.proj,
    Environment      = var.env
  } 
}

# Security Group for ALB
module "ecr_security_group_alb" {
  source        = "../modules/security_group"
  name          = "application-service-${var.env}-sg-alb"
  description   = "Security Group for ALB"
  vpc_id        = module.vpc_info.vpc_id  

  ingress_rules = [{
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      cidr         = ["0.0.0.0/0"]
  }]

  egress_rules = [{
      from_port    = 3000
      to_port      = 3000
      protocol     = "tcp"
      source_security_group_id  = module.security_group_ecs_service.security_group_id
  }]

  tags          = {
    Name        = "application-service-${var.env}-sg-alb",
    Project     = var.proj,
    Environment = var.env
  }
}


module "vpc_info_alb" {
  source = "../modules/vpc_info"
  vpc_id = var.vpc_id
  filter_value = [var.env == "dev" ? "DL_GRAF_DEV_VPC-PUBLIC" : "DL_GRAF_PROD_VPC-PUBLIC"]
}

# Create ALB for entry point 
module "alb" {
  source            = "../modules/alb"
  name              = "DL-application-${var.env}-ALB"
  security_groups = [module.ecr_security_group_alb.security_group_id]
  subnets           = module.vpc_info_alb.subnet_ids
  certificate_arn   = var.certificate_arn
  vpc_id            = module.vpc_info_alb.vpc_id
  tags = {
    Name = "DL-application-${var.env}-ALB",
    Project = var.proj,
    LZ_WAF_Exclusion = false
    Environment = var.env
  }
}

