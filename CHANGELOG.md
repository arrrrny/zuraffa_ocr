## 7.3.2 - 2026-10-31

Mono-version fleet alignment to 7.3.2: outbound send port lands in zuraffa_intents (shareText/shareFiles behind ShareIntentService); the whole family ships at one version.

## 7.3.0 - 2026-10-28

- Mono-version fleet alignment: the whole zuraffa family ships at 7.3.0 together with the core.
- `zuraffa` dependency constraints unified to ^7.3.0; cross-family constraints move with the release.
- Fleet-wide `dependency_overrides: xml: 7.1.0`; README install guides refreshed to 7.3.0.

## 7.2.0 - 2026-10-28

- Mono-version fleet alignment: the whole zuraffa family now ships at the same version as the core.
- `zuraffa` dependency constraint unified to ^7.2.0 across the fleet.
- zuraffa_storage now wraps the maintained `zuraffa_minio` fork instead of the abandoned `minio` package (xml 7 compatible).
- Fleet-wide `dependency_overrides: xml: 7.1.0` policy; README install guides refreshed to the release version.

# Changelog

## 0.1.1 - 2026-09-23

- Widened the `zuraffa` constraint from `^6.2.2` to `^7.0.0` across all five
  packages so the family resolves alongside zuraffa 7.x. No API changes — the
  suite passes unchanged against 7.0.1.

## 0.1.0

- Initial federated scaffold for `zuraffa_ocr` (EPIC #214 migration): the
  app-facing package, the shared `zuraffa_ocr_platform` envelope core, and the
  Android, iOS, macOS adapters.
