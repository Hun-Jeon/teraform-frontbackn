# 운영·일상 명령

`project/backend/dev` 환경 경로에서 실행합니다.

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

## Bastion 경유 DB 접속 체크리스트

- RDS 엔드포인트는 `host:port` 형태로 출력되므로, SSH 터널에서는 호스트와 포트를 분리해 사용합니다.
- SSH 터널 예시: `ssh -i ~/.ssh/id_ed25519 -N -L 13306:<rds-host>:3306 ec2-user@<bastion-public-ip>`
- DataGrip 사용 시: Host `127.0.0.1`, Port `13306`, User `admin`, Password는 Vault에 저장된 값으로 입력합니다.
- CLI 사용 시 `mysql` 명령이 없으면 클라이언트를 먼저 설치합니다 (`sudo apt install mysql-client-core-8.0` 또는 `mariadb-client-core`).
- 자주 보는 오류:
  - `Permission denied (publickey)`: SSH 키 불일치 또는 Bastion SG의 허용 IP(`my_actual_ip`) 불일치
  - `bind: Address already in use`: 로컬 포트 충돌(예: `13307`로 변경)
  - `Access denied for user`: DB 사용자/비밀번호 불일치
