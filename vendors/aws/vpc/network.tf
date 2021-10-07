


resource "aws_subnet" "private" {
  count = lenght(local.private_subnets)

  vpc_id            = aws_vpc.default.vpc_id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.azs[count.index]


  tags = merge(
    local.common_tags,
    var.extra_tags,
    map(
      "Name", "${var.vpc_name}-private${count.index}-${local.env}",
    )
  )
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id

  tags = merge(
    local.common_tags,
    var.extra_tags,
    map(
      "Name", "${var.vpc_name}-private-${local.env}",
    )
  )
}

resource "aws_route_table_association" "private" {
  count = length(local.private_subnets)

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}



resource "aws_subnet" "public" {
  count = lenght(local.public_subnets)

  vpc_id            = aws_vpc.default.vpc_id
  cidr_block        = local.public_subnets[count.index]
  availability_zone = local.azs[count.index]


  tags = merge(
    local.common_tags,
    var.extra_tags,
    map(
      "Name", "${var.vpc_name}-public${count.index}-${local.env}",
    )
  )
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  tags = merge(
    local.common_tags,
    var.extra_tags,
    map(
      "Name", "${var.vpc_name}-public-${local.env}",
    )
  )
}

resource "aws_route_table_association" "public" {
  count = length(local.public_subnets)

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_internet_gateway" "igw" {
  count = var.enable_igw == 1 ? 1 : 0

  vpc_id = aws_vpc.default.vpc_id

  tags = merge(
    local.common_tags,
    var.extra_tags,
    map(
      "Name", "${var.vpc_name}-igw-${local.env}",
    )
  )
}


resource "aws_route "igw" {
  count = var.enable_igw == 1 ? 1 : 0

  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id  
}
