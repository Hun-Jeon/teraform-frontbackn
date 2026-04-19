# Decisions Log

## DEC-001: Standardize API error response format
- Date: 2026-04-19
- Status: Accepted
- Context:
  - Different services return different error shapes, increasing frontend complexity.
- Decision:
  - Standardize all API errors to `{ code, message, details }`.
- Alternatives:
  - Keep existing shapes and branch on the frontend.
- Consequences:
  - Short-term migration work increases, long-term maintenance improves.
- Related Files:
  - `src/...`
  - `docs/...`
