import 'package:zuraffa/zuraffa.dart';
import 'package:zuraffa_ocr/zuraffa_ocr.dart';

import 'ios_ocr_channel.dart';
import 'ios_ocr_exception.dart';
import 'ios_ocr_port.dart';

/// Registers the iOS adapter on [GetIt.instance]: the
/// [OcrPort] over an injected channel. An injected [timeout] is
/// applied to the wired channel. Without a channel every call surfaces
/// the typed `channel_not_wired` failure.
void registerIosOcrDependencies(
  GetIt getIt, {
  IosOcrChannel? channel,
  Duration? timeout,
}) {
  final wired = (channel == null)
      ? IosOcrChannel(
          invoke: (_, __) => throw const IosOcrException(
            'channel_not_wired',
            'No iOS channel was injected — pass one to '
            'registerIosOcrDependencies.',
            recoverable: false,
          ),
        )
      : (timeout == null)
          ? channel
          : IosOcrChannel(
              invoke: channel.invoke,
              timeout: timeout,
            );
  getIt.registerLazySingleton<OcrPort>(
    () => IosOcrPort(channel: wired),
  );
}
