variable "APP_NAME" {
  type = string
  
}

variable "ENV" {
  type = string
  
}

variable "AWS_REGION" {
  type = string
 
}

variable "cluster-subnets" {
  default = {
    "a" = 1
    "b" = 2
    "c" = 3
  }
}





