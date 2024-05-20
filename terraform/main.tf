provider "aws" {
  region = "ap-southeast-1"
  profile = "personal"
}

resource "aws_instance" "fastapi_mysql" {
  ami           = "ami-0a95d2cc973f39afc"  # Amazon Linux 2 AMI (change to your preferred AMI)
  instance_type = "t3.medium"  # Instance type with enough memory and CPU

  key_name = var.key_name  # SSH key name for access

  vpc_security_group_ids = [aws_security_group.fastapi_sg.id]

  tags = {
    Name = "FastAPI-MySQL-Instance"
  }
}

resource "aws_security_group" "fastapi_sg" {
  name        = "fastapi_sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fastapi_sg"
  }
}

resource "aws_ebs_volume" "data_volume" {
  availability_zone = aws_instance.fastapi_mysql.availability_zone
  size              = 50  # Size in GB

  tags = {
    Name = "FastAPI-MySQL-Volume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.data_volume.id
  instance_id = aws_instance.fastapi_mysql.id
}
