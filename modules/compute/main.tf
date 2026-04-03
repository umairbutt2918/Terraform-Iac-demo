resource "tls_private_key" "ssh_key" {
 algorithm = "RSA"
 rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
 key_name = "terraform-key"
 public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_security_group" "ssh_sg" {
 name = "allow-ssh"
 vpc_id = var.vpc_id

 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "web" {
 ami = "ami-0c02fb55956c7d316"
 instance_type = "t3.micro"

 subnet_id = var.subnet_id
 vpc_security_group_ids = [aws_security_group.ssh_sg.id]

 key_name = aws_key_pair.generated_key.key_name
}