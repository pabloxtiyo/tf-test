variable "region" {}

variable "project_id" {} 

variable "project_name" {}

variable "project_number" {}

variable "deployment_env" {}

variable "nodes_count" {}

variable "default_sa" {}

variable "authorized_networks" {
  type    = list(string)
  default = [""]
}

