resource "aws_instance" "instance" {
  ami                         = "ami-06b21ccaeff8cd686" # Specify the base AMI ID
  instance_type               = "t2.micro"              # Specify the instance type
  associate_public_ip_address = true                    # Adjust as needed
  subnet_id                   = aws_subnet.public_subnet[0].id
  #key_name                    = aws_key_pair.example_key_pair.key_name
  security_groups             = [aws_security_group.ec2_sg.id]




  user_data = filebase64("userdata.sh")
  tags = {
    Name = "example-instance"
  }

}

resource "aws_security_group" "ec2_sg" {
  name        = "custom-ec2-sg"
  description = "Security Group for Webserver Instance"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom-ec2-sg"
  }
}
