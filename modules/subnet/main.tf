resource "aws_subnet" "this" {
  count = length(var.subnet_cidrs)

  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet-${count.index}"
  }
}
