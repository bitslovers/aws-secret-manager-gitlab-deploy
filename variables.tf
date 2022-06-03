# Secrets
variable "SECRETS_LIST" {
  description = "Map of secrets to deploy in AWS Secrets Manager"
  type        = any
  default     = {}
}

variable "REGION" {
  default     = "us-east-1"
  description = "Region in which to create resources."
}

variable "OWNER" {
  description = "Owner of the project"
  default = "Bits"
}