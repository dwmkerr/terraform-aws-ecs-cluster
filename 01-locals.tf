locals {
  tags = "${merge(
    var.tags,
    map(
      "Origin", "github.com/dwmkerr/terraform-aws-ecs-cluster",
    )
  )}"
}
