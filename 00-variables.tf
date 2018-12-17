variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1."
  type = "string"
  default = "us-east-1"
}

variable "instance_size" {
  description = "The size of the cluster nodes, e.g: t2.large."
  type = "string"
  default = "t2.small"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  type = "string"
  default = "10.0.0.0/16"
}

variable "subnets" {
  description = "The subnets which is a map of availability zones to CIDR blocks, which subnet nodes will be deployed in."
  type = "map"
  default = {
    us-east-1a = "10.0.1.0/24"
    us-east-1b = "10.0.2.0/24"
    us-east-1c = "10.0.3.0/24"
  }
}

variable "key_name" {
  description = "The name of the key to user for ssh access, e.g: ecs-cluster"
  type = "string"
  default = "ecs_cluster"
}

variable "public_key_path" {
  description = "The local public key path, e.g. ~/.ssh/id_rsa.pub"
  type = "string"
  default = ""
}

variable "node_count" {
  description = "The number of nodes"
  type = "string"
  default = "3"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type = "string"
  default = "ecs_cluster"
}

variable "instance_security_groups" {
  description = "Additional security groups for ECS instances"
  type = "list"
  default = []
}

variable "tags" {
  description = "Additional tags to add to resources"
  type = "map"
  default = {}
}
