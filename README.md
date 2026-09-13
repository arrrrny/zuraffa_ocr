# zuraffa_ocr — monorepo

Typed OCR support for the Zuraffa ecosystem: a pure-Dart port, recognition lifecycle, and typed failures behind an injected platform channel with federated adapters.

Built on the [Zuraffa](https://pub.dev/packages/zuraffa) framework as part
of the zuraffa-native package family (EPIC #214).

## Packages

| Package | Description |
| --- | --- |
| [`packages/zuraffa_ocr`](packages/zuraffa_ocr/) | App-facing package: `OcrPort`, `OcrService`, typed failures + DI registration |
| [`packages/zuraffa_ocr_platform`](packages/zuraffa_ocr_platform/) | Shared channel-envelope core over an injected platform channel |
| [`packages/zuraffa_ocr_android`](packages/zuraffa_ocr_android/) | Android adapter (typed taxonomy over the injected channel) |
| [`packages/zuraffa_ocr_ios`](packages/zuraffa_ocr_ios/) | iOS adapter (typed taxonomy over the injected channel) |
| [`packages/zuraffa_ocr_macos`](packages/zuraffa_ocr_macos/) | macOS adapter (typed taxonomy over the injected channel) |

Publish from each package directory (`packages/<name>`); the federated
siblings depend on each other via hosted dependencies — see
[`PUBLISH.md`](PUBLISH.md) and `scripts/` for the publish pipeline.

See [`specs/`](specs/) for the spec-driven development records.

Repository: https://github.com/arrrrrny/zuraffa_ocr
