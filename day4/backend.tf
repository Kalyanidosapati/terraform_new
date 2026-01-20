terraform {
  backend "s3" {
    bucket = "new-buckt-terra-statefile"
    key    = "statefile/terraform.tfstate"
    region = "ap-south-1"
    encrypt  = true
    dynamodb_table = "terraform-lock"
  }
}

