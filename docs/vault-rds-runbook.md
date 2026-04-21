# Vault 기반 RDS 비밀번호 주입 Runbook

이 문서는 Terraform Cloud 원격 실행 환경에서 Vault 자격 증명을 사용해 RDS를 생성한 작업 내용을 정리한 기록입니다.

## 목표

- RDS 비밀번호를 코드/변수 파일에 직접 저장하지 않는다.
- Terraform 실행 시 Vault에서 비밀번호를 읽어 `aws_db_instance`에 주입한다.
- 실행 실패 시 자주 발생한 JWT 인증 오류를 빠르게 진단한다.

## 현재 코드 반영 사항

### Vault provider

`provider.tf`

- `vault` provider를 선언해 Vault 데이터 소스 사용 가능 상태로 구성

### Vault 데이터 소스

`data.tf`

- `data "vault_kv_secret_v2" "rds_creds"` 사용
- 마운트: `tfc`
- 시크릿 경로: `rds/mysql/dev-rds`
- 최종적으로 `data["password"]` 키를 참조

### RDS 비밀번호 연결

`rds.tf`

- `password = data.vault_kv_secret_v2.rds_creds.data["password"]`
- `lifecycle.ignore_changes = [password]` 적용
  - Vault 내부 비밀번호 변경만으로 불필요한 즉시 교체/드리프트 노이즈를 줄이기 위한 설정

## 실행 전 체크리스트

- Vault에 KV v2 시크릿이 존재하는지 확인
  - 마운트: `tfc`
  - 경로: `rds/mysql/dev-rds`
  - 필수 키: `password`
- Terraform Cloud Workspace에 Vault 연동 변수/설정이 준비되었는지 확인
- Vault JWT auth role에서 Workspace를 식별할 클레임 매핑이 올바른지 확인

## 오늘 발생했던 오류와 해결

### 1) `invalid audience (aud) claim`

증상:

- Vault JWT 로그인 단계에서 `audience claim does not match any expected audience`

원인:

- 토큰의 `aud` 값과 Vault role의 `bound_audiences` 값 불일치

해결:

- Vault role의 `bound_audiences`를 실제 발급 토큰의 audience와 일치하도록 수정

### 2) `claim "terraform_full_workspace_path" not found in token`

증상:

- Vault JWT 로그인 단계에서 `bound_claims` 검증 실패

원인:

- Vault role이 요구하는 클레임 키(`terraform_full_workspace_path`)가 실제 토큰에 없음

해결:

- Vault role의 `bound_claims`를 실제 토큰에 포함된 클레임 키 기준으로 재설정
- 필요 시 불일치하는 legacy 클레임 조건 제거

## 운영 가이드

- 민감정보는 `.tf`, `.tfvars`, 출력값에 직접 남기지 않는다.
- Vault의 비밀번호를 로테이션할 때는 애플리케이션 영향 범위를 먼저 확인한다.
- 비밀번호 변경 전략(즉시 교체/점진 반영)은 팀 운영 정책으로 분리해 관리한다.

## 참고 파일

- `provider.tf`
- `data.tf`
- `rds.tf`
- `docs/operations.md`
