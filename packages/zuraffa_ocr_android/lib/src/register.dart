import 'package:zuraffa/zuraffa.dart';
import 'package:zuraffa_ocr/zuraffa_ocr.dart';

import 'android_ocr_channel.dart';
import 'android_ocr_exception.dart';
import 'android_ocr_port.dart';

/// Registers the Android adapter on [GetIt.instance]: the
/// [OcrPort] over an injected channel. An injected [timeout] is
/// applied to the wired channel. Without a channel every call surfaces
/// the typed `channel_not_wired` failure.
void registerAndroidOcrDependencies(
  GetIt getIt, {
  AndroidOcrChannel? channel,
  Duration? timeout,
}) {
  final wired = (channel == null)
      ? AndroidOcrChannel(
          invoke: (_, __) => throw const AndroidOcrException(
            'channel_not_wired',
            'No Android channel was injected — pass one to '
            'registerAndroidOcrDependencies.',
            recoverable: false,
          ),
        )
      : (timeout == null)
          ? channel
          : AndroidOcrChannel(
              invoke: channel.invoke,
              timeout: timeout,
            );
  getIt.registerLazySingleton<OcrPort>(
    () => AndroidOcrPort(channel: wired),
  );
}
