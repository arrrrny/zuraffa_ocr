# zuraffa_ocr_platform

Shared channel-envelope core for the zuraffa_ocr platform adapters: decode,
typed-error plumbing, and timeout policy over an injected platform
channel. Adapters bring their own typed exception and taxonomy; the core
never invents one.

Part of the [zuraffa_ocr](https://github.com/arrrrrny/zuraffa_ocr) federated monorepo.

## Develop

```bash
dart pub get
dart test
```
