//  Define the VPC.
resource "aws_vpc" "ecs_cluster" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.tags,
    map("Name", "ECS Cluster VPC")
  )}"
}

//  Create an Internet Gateway for the VPC.
resource "aws_internet_gateway" "ecs_cluster" {
  vpc_id = "${aws_vpc.ecs_cluster.id}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.tags,
    map("Name", "ECS Cluster IGW")
  )}"
}

//  Define each of the required subnets.
resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.subnets)}"

  vpc_id                  = "${aws_vpc.ecs_cluster.id}"
  cidr_block              = "${element(values(var.subnets), count.index)}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.ecs_cluster"]
  availability_zone       = "${element(keys(var.subnets), count.index)}"

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.tags,
    map("Name", "ECS Cluster Public Subnet ${count.index+1}")
  )}"
}

//  Create a route table allowing all addresses access to the IGW.
resource "aws_route_table" "public_routes" {
  vpc_id = "${aws_vpc.ecs_cluster.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ecs_cluster.id}"
  }

  //  Use our common tags and add a specific name.
  tags = "${merge(
    local.tags,
    map("Name", "ECS Cluster Public Route Table")
  )}"
}

//  Now associate the route table with the public subnet - giving
//  all public subnet instances access to the internet.
resource "aws_route_table_association" "public_subnet_routes" {
  count = "${length(var.subnets)}"

  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_routes.id}"
}
