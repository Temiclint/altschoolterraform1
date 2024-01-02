resource "aws_instance" "instance" {
  ami               = var.ami
  instance_type     = var.type
  key_name          = var.key_pair
  security_groups   = [aws_security_group.security-group.id]
  subnet_id         = aws_subnet.public_subnet_az1.id
  availability_zone = data.aws_availability_zones.available_zones.names[0]


  tags = {
    Name   = "${var.project_title}-instance"
    source = "terraform"

  }
}
