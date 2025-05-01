data "terraform_remote_state" "tf_states" {
  backend  = "s3"

  config   = {
    bucket = "${var.env}-application-terraform-state"
    #bucket = var.env == "dev" ? "dev-account-ap-southeast-1-application-terraform-state" : "prod-account-ap-southeast-1-application-terraform-state"
    key    = "application/infra/terraform.tfstate"
    region = "ap-southeast-1"
  }
}



resource "null_resource" "application_pull_and_tag" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "bash ${path.root}/../tools/application_dockerhub.sh ${var.tag}"
  }
}

module "deploy_application" {
  source              = "../modules/application"
  service_name        = "application-${var.env}-svc"
  cluster             = data.terraform_remote_state.tf_states.outputs.cluster_id
  SubnetIds           = data.terraform_remote_state.tf_states.outputs.subnet_ids
  container_name      = "application-${var.env}-app"
  SecurityGroupIds    = [data.terraform_remote_state.tf_states.outputs.ecs_security_group_id] 
  target_group_arn    = data.terraform_remote_state.tf_states.outputs.target_group_arn
  
  # Task Definition
  repository_name     = data.terraform_remote_state.tf_states.outputs.ecr_repository_name
  gf_server_root_url  = var.gf_server_root_url
  file_system_id      = data.terraform_remote_state.tf_states.outputs.efs_id
  efs_access_point_id = data.terraform_remote_state.tf_states.outputs.efs_access_point_id
  env                 = var.env
  tags                = {
    Name              = "application-${var.env}-app",
    Project           = var.proj,
    Environment       = var.env
  }
}
