resource "aws_instance" "workshop0001-nginx-plus-gateway-1" {
  ami                         = data.aws_ami.workshop0001-ngx-plus.id # eu-west-2
  instance_type               = "t2.medium"
  key_name                    = "workshop0001-nginx-server-key"
  security_groups             = [aws_security_group.workshop0001-nginx-web-facing.id]
  subnet_id                   = aws_subnet.workshop0001-main.id
  private_ip                  = "10.0.1.20"
  
  tags = {
    Name = "workshop0001-nginx-plus-gateway-1"
  }

  
  
  
}



resource "null_resource" "gateway-1-join-controller" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    trigger1 = aws_route53_record.workshop0001-gateway1.ttl
  }
  
  provisioner "remote-exec" {
  
    connection {
    type     = "ssh"
    user     = "centos"
	private_key = file("~/.ssh/AWS-Mumbai/nginx-server-key.pem")
    host     = aws_instance.workshop0001-nginx-plus-gateway-1.public_ip
  }
  
        inline = [
		"#until sudo apt-get update -y; do sleep 10; done",
		"#until sudo apt-get upgrade -y; do sleep 10; done",
		"sudo sh -c 'echo -n ${ data.local_file.foo.content } >>/etc/hosts'",
		"sudo sh -c 'echo \" controller.workshop0001.nginxdemo.net\" >>/etc/hosts'",
		"ansible-playbook connect_nginx_server_to_controller.yaml",

    ]
  }

}