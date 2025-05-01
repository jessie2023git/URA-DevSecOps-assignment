variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "gf_server_root_url" {
  description = "application Root URL"
  type        = string
}

variable "proj" {
  description = "Project name"
  type        = string
}

variable "tag" {
  type    = string
  description = "application tag to be downloaded."
}