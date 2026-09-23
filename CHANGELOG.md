# Changelog

## 0.1.1 - 2026-09-23

- Widened the `zuraffa` constraint from `^6.2.2` to `^7.0.0` across all five
  packages so the family resolves alongside zuraffa 7.x. No API changes — the
  suite passes unchanged against 7.0.1.

## 0.1.0

- Initial federated scaffold for `zuraffa_ocr` (EPIC #214 migration): the
  app-facing package, the shared `zuraffa_ocr_platform` envelope core, and the
  Android, iOS, macOS adapters.
