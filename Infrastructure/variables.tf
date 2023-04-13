variable "APP_NAME" {
  type = string
  default = "books"
}

variable "ENV" {
  type = string
  default = "production"
}

variable "AWS_REGION" {
  type = string
  default = "eu-north-1"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret" {
  type = string
}

variable "SUBNETS" {
  default = {
    "a" = 1
    "b" = 2
    "c" = 3
  }
}
