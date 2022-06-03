terraform {
  required_providers {
    aws = {
      version = "~> 3.0"
    }
  }
}


terraform {
  backend "s3" {
    bucket  = "s3-for-terraform-state"
    key     = "sm/bitslovers/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

module "secret-manager" {
  source				            = "./modules/secret-manager"         
  REGION                    = "us-east-1"
  SECRETS_LIST              = var.SECRETS_LIST
}
