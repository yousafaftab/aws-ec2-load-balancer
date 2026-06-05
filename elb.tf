resource "aws_elb" "elb" {
  availability_zones = var.availability_zones
  name               = var.elb_name
  listener {
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol
  }
  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    target              = var.target
    interval            = var.interval
  }
  instances                   = [aws_instance.yousaf_ec2.id]
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout
  tags = {
    Name = var.elb_name
  }
}
