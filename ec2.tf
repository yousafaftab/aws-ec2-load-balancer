resource "aws_instance" "yousaf_ec2" {
  ami           = data.aws_ami.amazon_linux.image_id
  instance_type = var.instance_type
  subnet_id     = element(tolist(data.aws_subnets.all.ids), 0)
  tags = {
    Name = var.ec2_name
  }
}
