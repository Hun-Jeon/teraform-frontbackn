# 1. 최신 Amazon Linux 2023 AMI ID 가져오기 (하드코딩 방지)
data "aws_ami" "amzn_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# 2. SSH 키 페어 등록 (내 로컬의 공개키 사용)
# 미리 ssh-keygen 등으로 만든 id_rsa.pub 내용이 필요합니다.
resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  # 파일 경로 대신 변수를 직접 참조합니다.
  public_key = var.bastion_public_key
}

# 3. Bastion EC2 인스턴스 생성
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amzn_linux_2023.id
  instance_type = "t3.micro" # 프리티어 사양이면 충분합니다.

  # 이전에 만든 네트워크 리소스 참조
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = aws_key_pair.bastion_key.key_name

  # 퍼블릭 IP 자동 할당 확인
  associate_public_ip_address = true

  tags = {
    Name = "dev-bastion"
  }
}

# 4. 접속을 위한 퍼블릭 IP 출력
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
