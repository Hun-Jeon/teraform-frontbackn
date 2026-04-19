# frontbackn-dev-cli

AWS Terraform 실습용 프로젝트입니다. **서울 리전(`ap-northeast-2`)**에 VPC, 퍼블릭·프라이빗 서브넷, 인터넷 게이트웨이, 퍼블릭 라우팅을 구성합니다.

## 문서 (용도별)

| 문서 | 설명 |
| ---- | ---- |
| [docs/getting-started.md](docs/getting-started.md) | 사전 요구 사항, OS별 메모, 첫 `init` / `plan` |
| [docs/operations.md](docs/operations.md) | 일상 명령, Terraform Cloud 원격 실행, 상태 유의사항 |
| [docs/architecture.md](docs/architecture.md) | 백엔드·프로바이더·네트워크 구성 요약 |
| [docs/collaboration.md](docs/collaboration.md) | 여러 환경에서 맥락을 나누는 방법 |
| [docs/decisions/](docs/decisions/) | 아키텍처 결정 기록(ADR) |
| [CONTRIBUTING.md](CONTRIBUTING.md) | 기여 시 포맷·검증·문서 위치 |

## 빠른 시작

```bash
terraform init
terraform fmt && terraform validate && terraform plan
```

상세는 [docs/getting-started.md](docs/getting-started.md)를 참고하세요.

## 라이선스

조직·팀 정책에 맞게 라이선스 파일을 추가하세요.
