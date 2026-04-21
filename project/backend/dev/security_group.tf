# 내 로컬 공인 IP를 자동으로 가져오는 데이터 소스 (꿀팁!)
data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

# 1. Bastion Host용 보안 그룹
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from my IP"
  vpc_id      = aws_vpc.main.id

  # 인바운드: 내 IP에서만 SSH 허용
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_actual_ip]
  }

  # 아웃바운드: 모든 곳으로 나가는 것 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-bastion-sg" }
}

# 2. RDS용 보안 그룹 (Security Group Referencing 활용)
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow traffic only from Bastion"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # 핵심: IP 대역이 아니라 Bastion SG의 ID를 직접 참조합니다.
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "dev-rds-sg" }
}
