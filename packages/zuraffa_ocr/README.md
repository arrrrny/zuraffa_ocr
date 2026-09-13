# zuraffa_ocr

Typed OCR support for the Zuraffa ecosystem: a pure-Dart port, recognition lifecycle, and typed failures behind an injected platform channel with federated adapters.

Part of the [zuraffa_ocr](https://github.com/arrrrrny/zuraffa_ocr) federated monorepo, built on the
[Zuraffa](https://pub.dev/packages/zuraffa) framework.

## Use

```dart
final service = OcrService(port: myPlatformPort);
final module = await service.compile(id: 'demo', bytes: moduleBytes);
final results = await service.call(
    id: 'demo', export: 'run', args: [OcrI32(1)]);
await service.unload(id: 'demo');
```

Wire the platform adapter for the running platform first — e.g.
`registerAndroidOcrDependencies(getIt, channel: ...)` from
the adapter package — then resolve `OcrService`, or call
`registerOcrDependencies(getIt, port: ...)` directly. Without a
wired port every call surfaces the typed `port_not_wired` failure.

## Develop

```bash
dart pub get
dart test
```
