# Worklog

## 2026-04-20
- Terraform Cloud 원격 실행에서 Vault 자격 증명 연동으로 RDS 생성 성공
- `data.vault_kv_secret_v2.rds_creds`를 추가하고 `aws_db_instance.mysql.password`를 Vault 시크릿으로 연결
- `invalid audience (aud) claim` 오류를 Vault role의 `bound_audiences` 정합성 수정으로 해결
- `terraform_full_workspace_path not found in token` 오류를 Vault role `bound_claims` 재설정으로 해결
- `docs/vault-rds-runbook.md` 문서 추가 (절차/체크리스트/트러블슈팅 정리)
- Terraform 코드 경로를 루트에서 `project/backend/dev`로 재구성하고 실행 문서(`README`, `getting-started`, `operations`)를 새 경로 기준으로 업데이트

## 2026-04-19
- Start standardizing authentication error format
- Test status: update with pass/fail counts
- Next: complete frontend error mapping and add integration tests
