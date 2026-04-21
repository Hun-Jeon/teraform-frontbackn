variable "bastion_public_key" {
  type        = string
  description = "Bastion 서버 접속을 위한 공개키 값"
}

variable "my_actual_ip" {
  type        = string
  description = "SSH 접속을 허용할 내 로컬 공인 IP (e.g. 1.2.3.4/32)"
}

