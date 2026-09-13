# zuraffa_ocr_android

Android adapter for the [zuraffa_ocr](https://github.com/arrrrrny/zuraffa_ocr) federated monorepo:
the Ocr port over an injected platform channel, with the shared
envelope machinery from `zuraffa_ocr_platform` and a typed failure taxonomy
as pure data.

The channel transport is injected — no Flutter plugin boilerplate, no
native code in this repo. The consuming app (or a native shell) supplies
the `ChannelInvoke` seam:

```dart
import 'package:zuraffa/zuraffa.dart';
import 'package:zuraffa_ocr_android/zuraffa_ocr_android.dart';

void register() {
  registerAndroidOcrDependencies(
    GetIt.instance,
    channel: AndroidOcrChannel(
      invoke: (method, args) => nativeBridge.call(method, args),
    ),
  );
}
```

Without an injected channel every call surfaces the typed
`channel_not_wired` failure instead of hanging.

## Develop

```bash
dart pub get
dart test
```
