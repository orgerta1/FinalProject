output "WEB_CLIENT_BUCKET_NAME" {
  value = module.storage.web-client-bucket-name
}
output "ECR_REPOSITORY_NAME" {
  value = module.cluster.ecr_repository_name
}
output "DB_ADDRESS" {
  value = module.rds.db-address
}
output "DB_PORT" {
  value = module.rds.db-port
}
output "DB_USERNAME" {
  value = var.DB_USERNAME
}
output "DB_PASSWORD" {
  value = var.DB_PASSWORD
}
output "DB_NAME" {
  value = var.DB_NAME
}