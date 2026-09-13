import 'package:zuraffa/zuraffa.dart';
import 'package:zuraffa_ocr/zuraffa_ocr.dart';

import 'macos_ocr_channel.dart';
import 'macos_ocr_exception.dart';
import 'macos_ocr_port.dart';

/// Registers the macOS adapter on [GetIt.instance]: the
/// [OcrPort] over an injected channel. An injected [timeout] is
/// applied to the wired channel. Without a channel every call surfaces
/// the typed `channel_not_wired` failure.
void registerMacosOcrDependencies(
  GetIt getIt, {
  MacosOcrChannel? channel,
  Duration? timeout,
}) {
  final wired = (channel == null)
      ? MacosOcrChannel(
          invoke: (_, __) => throw const MacosOcrException(
            'channel_not_wired',
            'No macOS channel was injected — pass one to '
            'registerMacosOcrDependencies.',
            recoverable: false,
          ),
        )
      : (timeout == null)
          ? channel
          : MacosOcrChannel(
              invoke: channel.invoke,
              timeout: timeout,
            );
  getIt.registerLazySingleton<OcrPort>(
    () => MacosOcrPort(channel: wired),
  );
}
