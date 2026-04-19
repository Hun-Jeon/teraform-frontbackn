# 아키텍처 개요

## 백엔드·프로바이더

| 구분 | 내용 |
| ---- | ---- |
| 상태 백엔드 | Terraform Cloud — 조직 `lab-Apr`, 워크스페이스 `frontbackn-dev-cli` |
| 프로바이더 | `hashicorp/aws` `~> 5.0` (락 파일에 고정된 버전이 권위 있음) |
| 리전 | `ap-northeast-2` |

`main.tf`의 `terraform` 블록과 `provider "aws"`에서 정의합니다.

## 네트워크 (`network.tf`)

- **VPC** `10.0.0.0/16` — DNS 호스트네임·DNS 지원 활성화
- **Internet Gateway** — VPC와 인터넷 연결
- **퍼블릭 서브넷** `10.0.1.0/24` (`ap-northeast-2a`) — `map_public_ip_on_launch = true`
- **프라이빗 서브넷** `10.0.11.0/24` (`ap-northeast-2a`)
- **퍼블릭 라우트 테이블** — `0.0.0.0/0` → IGW, 퍼블릭 서브넷에 연결

### 학습 포인트

프라이빗 서브넷에는 아직 NAT Gateway·NAT Instance·VPC 엔드포인트가 없어 **인터넷으로 나가는 기본 경로는 없습니다.** RDS·Lambda 등을 넣을 때 아웃바운드 설계(NAT 또는 엔드포인트)를 단계적으로 추가하는 실습으로 이어가면 좋습니다.

## 확장 아이디어

- NAT + 프라이빗 라우트
- 다른 AZ에 서브넷 추가(다중 AZ)
- `outputs.tf`로 VPC·서브넷 ID 출력
- 보안 그룹, Bastion EC2, RDS 순차 추가

구조를 바꾸는 결정은 [decisions](./decisions/)에 ADR로 남기는 것을 권장합니다.
