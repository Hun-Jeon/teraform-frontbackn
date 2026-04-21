# Vault에서 RDS 비밀 정보를 읽어옵니다.
data "vault_kv_secret_v2" "rds_creds" {
  mount = "tfc"               # 마운트 이름 (tfc)
  name  = "rds/mysql/dev-rds" # 마운트 뒤의 상세 경로
}
