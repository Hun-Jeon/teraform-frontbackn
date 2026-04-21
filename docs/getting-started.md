# 시작하기

이 프로젝트는 **AWS 서울 리전(`ap-northeast-2`)**에 VPC·서브넷·IGW·퍼블릭 라우팅을 올리는 Terraform 실습용 코드입니다. 상세 구성은 [architecture.md](./architecture.md)를 참고하세요.

## 필요한 것

1. **Terraform** 1.x 이상 — [공식 설치 가이드](https://developer.hashicorp.com/terraform/install)
2. **AWS 자격 증명** — `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`, 또는 AWS CLI 프로파일 등 Terraform이 `ap-northeast-2`에 API 호출할 수 있는 형태
3. **Terraform Cloud**
   - 조직 `lab-Apr`, 워크스페이스 `frontbackn-dev-cli`가 준비되어 있어야 `terraform init`이 원격 백엔드에 연결됩니다.
   - CLI: `terraform login` 후 토큰 입력
   - 워크스페이스 **Execution mode**가 *Remote*이면 `plan`/`apply`가 TFC에서 실행되므로, TFC 쪽에도 AWS 자격 증명(워크스페이스 변수·OIDC 등)이 있어야 합니다.

## OS별 메모

| 환경 | 메모 |
| ---- | ---- |
| Windows | PowerShell에서도 동일한 Terraform 명령을 사용합니다. 경로에 공백이 있으면 따옴표로 감싸세요. |
| macOS | Homebrew 등으로 Terraform을 설치한 뒤, 터미널에서 이 저장소의 환경 경로로 이동합니다. |
| WSL2 | Linux 바이너리 기준으로 설치하면 됩니다. 저장소를 `/home/...` 쪽에 두면 I/O가 더 안정적인 경우가 많습니다. |

자격 증명은 **저장소에 커밋하지 마세요.** 환경 변수·프로파일·TFC 변수로만 주입합니다.

## 첫 실행

`project/backend/dev`에서:

```bash
cd project/backend/dev
terraform init
terraform fmt
terraform validate
terraform plan
```

`apply` 이후 절차와 운영 시 유의점은 [operations.md](./operations.md)를 참고하세요.
