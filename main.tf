resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.saivpc.id
  ingress = [
    for port in [22, 80, 443] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-ansible"
  }
}

resource "aws_instance" "sai" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.web.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true
  # user_data                   = templatefile("./install.sh", {})
  root_block_device {
    volume_size = 10

  }
  tags = {
    Name = "web"
  }
}

resource "null_resource" "sai" {
  triggers = {
    running_number = "2"
  }
  connection {
    type = "ssh"
    private_key = file("C:/Users/kumar/Downloads/bash.pem")
    host = aws_instance.sai.public_ip
    user = "ubuntu"

  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo apt update",
      "sudo apt install ansible -y",
      "sudo apt update",
      "sudo apt install jenkins -y",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"

     ]
  }
  depends_on = [ aws_instance.sai ]

}


