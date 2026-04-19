# Agent Handoff

## Current Focus
- Windows(WSL) + Mac 환경에서 Cursor/IntelliJ로 작업하되, AI agent가 문서 기반으로 작업 맥락을 공유할 수 있는 최소 운영체계 마련

## Last Updated
- Date: 2026-04-19
- Author: raidshoot (human) / GPT agent

## Done
- [x] `docs/`에 에이전트 핸드오프/의사결정/작업로그 템플릿 추가
- [x] OS/IDE 혼용 대비를 위한 `.gitattributes` 추가(LF 정책)
- [x] 기본 포맷 통일을 위한 `.editorconfig` 추가

## In Progress
- [ ] (없음) — 오늘은 템플릿/기반 세팅까지만 완료

## Next Actions (Priority)
1. 실제 프로젝트 스택에 맞게 `Verify Steps` 커맨드 확정(예: `terraform fmt`, `terraform validate`, `npm test` 등)
2. 템플릿 문구를 전부 한국어로 정리(원하면)하고, 불필요한 섹션은 삭제해 더 가볍게 운영
3. (선택) `docs/agent-handoff.md`를 “항상 최신 1개 상태”로 유지하는 운영 규칙을 README나 별도 문서에 3~5줄로 명문화

## Blockers / Risks
- 검증 커맨드/프로젝트 도구체인(예: Node/Python/Terraform) 확정 전이라 `Verify Steps`가 아직 placeholder 상태
- 여러 OS에서 줄바꿈/대소문자 차이로 diff가 지저분해질 수 있음(현재 `.gitattributes`/`.editorconfig`로 완화)

## Files Touched
- `src/...`
- `tests/...`
- `docs/...`

## Verify Steps
```bash
npm test
npm run lint
```

## Notes for Next Agent/Human
- 이 파일은 “현재 상태 1개”만 유지하고, 자세한 의사결정 맥락은 `docs/decisions.md`에만 남기기
