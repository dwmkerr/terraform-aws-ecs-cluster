//  Output some useful variables for quick SSH access etc.
# output "nodes" {
  # value = ["${aws_instance.web.*.public_dns}"]
# }

output "ecs_cluster_id" {
  value = "${aws_ecs_cluster.ecs_cluster.id}"
}

output "vpc_id" {
  value = "${aws_vpc.ecs_cluster.id}"
}
output "alb_id" {
  value = "${aws_alb.ecs_cluster.id}"
}
output "alb_arn" {
  value = "${aws_alb.ecs_cluster.arn}"
}
output "autoscaling_group_id" {
  value = "${aws_autoscaling_group.ecs_cluster_node.id}"
}
