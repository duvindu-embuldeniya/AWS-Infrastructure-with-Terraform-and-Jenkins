terraform {
  backend "s3" {
    bucket = "dev-proj-terraform-bucket-2002-duvindu"
    key    = "terraform/terraform.tfstate"
    region = "eu-north-1"
    encrypt = true
  }
}