# Fetch AWS NGINX Plus AMI identifiers
data "aws_ami" "workshop0001-ngx-plus" {
  most_recent = true
  owners      = ["self"]
  filter {
    name = "tag:Name"
    values = [
      "workshop0001-ngx-plus-Mumbai",
    ]
  }
}
# Fetch AWS NGINX Controller AMI identifiers
data "aws_ami" "workshop0001-nginx-controller" {
  most_recent = true
  owners      = ["self"]
  filter {
    name = "tag:Name"
    values = [
      "workshop0001-nginx-controller-Mumbai",
    ]
  }
}
