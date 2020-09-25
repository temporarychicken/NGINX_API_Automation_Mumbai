data "local_file" "foo" {
    filename = "private_ip.txt"
}

resource "aws_instance" "workshop0001-nginx-controller" {
  ami                         = data.aws_ami.workshop0001-nginx-controller.id # eu-west-2
  instance_type               = "c5.2xlarge"
  key_name                    = "workshop0001-controller-key"
  security_groups             = [aws_security_group.workshop0001-nginx-web-facing.id]
  subnet_id                   = aws_subnet.workshop0001-main.id
  private_ip                  = data.local_file.foo.content

 
  tags = {
    Name = "workshop0001-nginx-controller"
  }

}





#resource "null_resource" "nginx-controller" {
  # Changes to any instance of the cluster requires re-provisioning
#  triggers = {
#    the_trigger     =  aws_instance.workshop0001-nginx-controller.public_ip
#    another_trigger =	aws_route53_record.workshop0001-controller.zone_id
#  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
#  connection {
#    host = "${element(aws_instance.nginx-controller.*.public_ip, 0)}"
#  }

#  provisioner "remote-exec" {
#  
#    connection {
#    type     = "ssh"
#    user     = "ubuntu"
#	private_key = file("~/.ssh/AWS-Mumbai/controller-key.pem")
#    host     = aws_instance.nginx-controller.public_ip
#  }
#  
#        inline = [
#  	    "sh ./install-controller.sh"
#    ]
#  }

#}
