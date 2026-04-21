# 1. VPC 생성 (거대한 부지 확보)
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true # 도메인 주소 사용 설정
  enable_dns_support   = true

  tags = {
    Name = "dev-vpc"
  }
}

# 2. 인터넷 게이트웨이 (VPC의 대문)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-igw"
  }
}

# 3. 퍼블릭 서브넷 (외부 통신용 공간 - Bastion Host 배치 예정)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true # 이 서브넷에 생성되는 EC2는 퍼블릭 IP를 자동으로 할당받음

  tags = {
    Name = "dev-public-sn"
  }
}

# 4. 프라이빗 서브넷 (내부 보안 공간 - RDS 배치 예정)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "dev-private-sn"
  }
}

# RDS를 위한 두 번째 프라이빗 서브넷 (다른 AZ: 2c)
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-northeast-2c"

  tags = { Name = "dev-private-sn-2" }
}

# 5. 퍼블릭 라우팅 테이블 (외부로 나가는 길 안내판)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # 모든 외부 트래픽(인터넷)은
    gateway_id = aws_internet_gateway.igw.id # 대문(IGW)으로 보내라
  }

  tags = {
    Name = "dev-public-rt"
  }
}

# 6. 서브넷과 라우팅 테이블 연결 (퍼블릭 서브넷에 길 안내판 설치)
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
