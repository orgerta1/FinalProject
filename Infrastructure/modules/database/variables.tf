variable "APP_NAME" {
  type = string
}

variable "DB_SUBNETS" {
  type = list(string)
}

variable "DB_USERNAME" {
  type = string
}

variable "DB_PASSWORD" {
  type = string
}

variable "DB_NAME" {
  type = string
}

variable "DB_AZ" {
  type = string
}

variable "VPC_ID" {
  type = string
}
