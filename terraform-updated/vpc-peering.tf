resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
}

resource "aws_route" "vpc1_to_vpc2" {
  route_table_id            = aws_vpc.vpc1.default_route_table_id
  destination_cidr_block    = var.vpc2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "vpc2_to_vpc1" {
  route_table_id            = aws_vpc.vpc2.default_route_table_id
  destination_cidr_block    = var.vpc1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

