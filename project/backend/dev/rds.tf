# 1. RDS 서브넷 그룹 (어느 서브넷들에 DB를 둘지 지정)
resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_2.id]

  tags = { Name = "dev-db-subnet-group" }
}


# 3. RDS 인스턴스 생성
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro" # 프리티어 사양
  db_name              = "devdb"
  username             = "admin"
  password             = data.vault_kv_secret_v2.rds_creds.data["password"]
  # 보안을 위해 권장하는 설정
  lifecycle {
    ignore_changes = [password]
  }

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true  # 실습용이므로 삭제 시 스냅샷 생성 안 함
  multi_az            = false # 비용 절감을 위해 싱글 AZ (운영 시에는 true 권장)
  publicly_accessible = false # 외부 접근 차단 (프라이빗)

  tags = { Name = "dev-rds" }
}

# 4. 접속 주소(Endpoint) 출력
output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
