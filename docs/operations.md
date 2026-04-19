# 운영·일상 명령

프로젝트 루트에서 실행합니다.

## 자주 쓰는 명령

| 명령 | 설명 |
| ---- | ---- |
| `terraform init` | 프로바이더 다운로드 및 백엔드(Terraform Cloud) 초기화 |
| `terraform fmt` | `.tf` 파일 포맷 정리 |
| `terraform fmt -check` | CI에서 포맷 위반만 검사할 때 |
| `terraform validate` | 구문·기본 제약 검증 |
| `terraform plan` | 변경 예정 요약 |
| `terraform apply` | 승인 후 인프라 반영 |

## Terraform Cloud(원격 실행)

워크스페이스가 **Remote** 실행이면 `plan`/`apply`가 TFC 에이전트에서 돌아갑니다. 이 경우:

- 로컬 터미널의 AWS 자격 증명만으로는 부족할 수 있고, **TFC에 설정된 변수·OIDC**가 적용됩니다.
- 로그와 승인 UI는 Terraform Cloud 콘솔에서 확인합니다.

실행 모드가 **Local**에 가깝게 쓰는 설정이라면 팀 정책 문서에 맞춰 [decisions](./decisions/)에 변경 이유를 남기는 것이 좋습니다.

## 상태 파일

원격 백엔드를 쓰면 상태는 기본적으로 Terraform Cloud에 저장됩니다. 로컬에 `.terraform/` 또는 `*.tfstate`가 생기더라도 **민감 정보가 포함될 수 있으므로 Git에 올리지 않습니다** (루트 `.gitignore` 참고).

## 문제가 생겼을 때

- `init` 실패: 조직·워크스페이스 이름, `terraform login` 토큰, 네트워크를 확인합니다.
- `plan`/`apply` 권한 오류: IAM과 TFC 변수의 리전·계정이 일치하는지 확인합니다.
