variable "subnet_ids" {
  description = "List of IDs of the subnets"
  type        = list(string)
}

variable "route_table_id" {
  description = "The ID of the route table"
  type        = string
}
