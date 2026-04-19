# 1. Terraform Cloud를 원격 백엔드로 사용

날짜: 2026-04-19
상태: 수락됨

## 맥락

개인·소규모 실습에서도 상태 파일을 로컬만에 두면 기기 간 공유·잠금·이력 관리가 어렵고, 실수로 Git에 상태를 올릴 위험이 있습니다.

## 결정

Terraform Cloud 조직 `lab-Apr`, 워크스페이스 `frontbackn-dev-cli`에 상태를 두고, `main.tf`의 `cloud` 블록으로 연결합니다.

## 결과

- 상태가 원격에 집중되어 팀원이 같은 워크스페이스를 기준으로 작업하기 쉽습니다.
- Execution mode가 Remote이면 TFC 쪽 AWS 자격 증명 설정이 별도로 필요합니다 ([getting-started.md](../getting-started.md) 참고).

## 대안

- S3 + DynamoDB 잠금 테이블으로 자체 백엔드 구성
- 로컬 백엔드만 사용(비권장: 협업·CI와 맞물리기 어려움)
