resource "aws_launch_template" "web" {
  name_prefix   = "web-launch-template-"
  image_id      = var.web_ami_id
  instance_type = var.web_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.web_sg_ids

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = var.app_ami_id
  instance_type = var.app_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.app_sg_ids

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "web" {
  name        = "web-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "app" {
  name        = "app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb" "web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.external_alb_sg_ids
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false
  idle_timeout               = 60

  tags = {
    Name = "web-alb"
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb" "app" {
  name               = "app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.internal_alb_sg_ids
  subnets            = var.private_app_subnet_ids

  enable_deletion_protection = false
  idle_timeout               = 60

  tags = {
    Name = "app-alb"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_autoscaling_group" "web" {
  desired_capacity     = var.web_desired_capacity
  max_size             = var.web_max_size
  min_size             = var.web_min_size
  vpc_zone_identifier  = var.public_subnet_ids
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.web.arn]

  tag {
    key                 = "Name"
    value               = "web-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  desired_capacity     = var.app_desired_capacity
  max_size             = var.app_max_size
  min_size             = var.app_min_size
  vpc_zone_identifier  = var.private_app_subnet_ids
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app.arn]

  tag {
    key                 = "Name"
    value               = "app-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
