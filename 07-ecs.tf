# The ECS cluster.
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_cluster_name}"
}

# A security group for the cluster load balancer.
resource "aws_security_group" "http-ingress" {
  name        = "http-ingress"
  description = "Allow incoming HTTP"
  vpc_id      = "${aws_vpc.ecs_cluster.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A load balancer for the cluster.
resource "aws_alb" "ecs_cluster" {
    name                = "ecs-cluster"
    //  Allow ingress to the load balancer, and allow it to talk to all nodes
    //  in the VPC.
    security_groups = [
      "${aws_security_group.http-ingress.id}",
      "${aws_security_group.intra_node_communication.id}",
    ]
    subnets = ["${aws_subnet.public_subnet.*.id}"]
}
