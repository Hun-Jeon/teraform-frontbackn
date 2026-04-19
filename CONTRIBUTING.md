# 기여 가이드

## 저장소 구조

| 경로 | 용도 |
| ---- | ---- |
| `main.tf` | Terraform Cloud 백엔드, `required_providers`, AWS 프로바이더 |
| `network.tf` | VPC, 서브넷, IGW, 퍼블릭 라우팅 |
| `.terraform.lock.hcl` | 프로바이더 버전 고정 — **커밋에 포함** |
| `docs/` | 시작 방법, 운영, 아키텍처, 협업, ADR |

## 변경 전 체크리스트

1. `terraform fmt`로 포맷을 맞춥니다.
2. `terraform validate`가 통과하는지 확인합니다.
3. 의미 있는 인프라·워크플로 변경이면 [docs/decisions/](docs/decisions/)에 ADR을 추가하거나 기존 ADR 상태를 갱신합니다.

## 브랜치·리뷰

팀 정책이 정해져 있으면 그에 따르고, 없다면 작은 단위로 PR을 나누고 본문에 **목적·TFC/ AWS 영향 범위**를 적어 주세요.

## 비밀·상태

- AWS 키, 세션 토큰, `*.tfstate` 내용을 커밋하지 않습니다.
- `.terraform/`은 `.gitignore`에 있습니다.

## 문서

새로운 “팀이 알아야 할 맥락”이 생기면 README를 비대하게 만들기보다 [docs/collaboration.md](docs/collaboration.md)의 표를 참고해 적절한 `docs/` 파일을 갱신하거나 ADR을 추가합니다.
