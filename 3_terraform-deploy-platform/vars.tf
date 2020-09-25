variable "region" {
  default = "ap-south-1"
}

provider "aws" {
  profile    = "default"
  region     = var.region
}

