variable "APP_NAME" {
  type = string
}

variable "PUBLIC_SUBNET_IDS" {
  type = list(string)
}

variable "EKS_WORKER_NODE_INSTANCE_TYPE" {
  type    = string
  default = "t3.small"
}

variable "EKS_CLUSTER_MIN_SIZE" {
  type    = number
  default = 1
}

variable "EKS_CLUSTER_MAX_SIZE" {
  type    = number
  default = 2
}

variable "EKS_CLUSTER_DESIRED_SIZE" {
  type    = number
  default = 1
}
