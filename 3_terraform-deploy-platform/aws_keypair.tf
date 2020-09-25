resource "aws_key_pair" "workshop0001-controller" {
  key_name   = "workshop0001-controller-key"
  public_key = file ("~/.ssh/AWS-Mumbai/controller-key.pub")
}
resource "aws_key_pair" "workshop0001-nginx-server" {
  key_name   = "workshop0001-nginx-server-key"
  public_key = file ("~/.ssh/AWS-Mumbai/nginx-server-key.pub")
}
