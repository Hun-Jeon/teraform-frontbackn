# 협업·맥락 공유

Git으로 **소스 코드와 문서**는 같이 움직이지만, IDE 채팅 이력·로컬 분석 노트·개인 환경 설정은 저장소에 자동으로 포함되지 않습니다. 여러 사람·여러 OS(Windows, macOS, WSL)에서 일할 때는 아래를 기준으로 맞추면 좋습니다.

## 무엇을 저장소에 남길까

| 남길 내용 | 권장 위치 |
| --------- | --------- |
| “왜 이렇게 했는지” (되돌리기 어려운 선택) | [docs/decisions/](./decisions/) ADR |
| 인프라 구성 요약·용어 정리 | [architecture.md](./architecture.md) |
| 설치·자격 증명·TFC 연결 | [getting-started.md](./getting-started.md) |
| 일상 명령·운영 유의점 | [operations.md](./operations.md) |
| 기여 규칙·브랜치·리뷰 | 루트 [CONTRIBUTING.md](../CONTRIBUTING.md) |
| 이슈 단위 논의·스크린샷·재현 절차 | 이슈 트래커·PR 본문 |

README는 **처음 온 사람이 빠르게 진입**하도록 짧게 유지하고, 세부는 위 파일로 분산합니다.

## Cursor·에이전트 사용 시

팀 전체가 같은 힌트를 쓰고 싶다면 저장소에 포함되는 **`.cursor/rules`**, **`AGENTS.md`** 같은 메커니즘을 검토합니다. (이 저장소에는 아직 없을 수 있음.)

## 라이선스

조직 정책에 맞게 루트에 라이선스 파일을 추가하세요.
