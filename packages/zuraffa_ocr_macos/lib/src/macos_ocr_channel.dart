import 'package:zuraffa_ocr_platform/zuraffa_ocr_platform.dart';

import 'macos_ocr_exception.dart';

/// The macOS channel: the shared
/// [PlatformOcrEnvelope] machinery with the macOS
/// taxonomy as a pure data set.
class MacosOcrChannel {
  /// Native codes that map recoverable; everything else (including
  /// unknown codes) is non-recoverable, preserved verbatim.
  static const Set<String> recoverableCodes = {
    'user_cancelled',
    'api_unavailable',
    'not_supported',
    'timeout',
  };

  final ChannelInvoke invoke;
  final Duration timeout;

  const MacosOcrChannel({
    required this.invoke,
    this.timeout = const Duration(seconds: 30),
  });

  Future<Map<String, Object?>?> call(
    String method,
    Map<String, Object?> args,
  ) =>
      PlatformOcrEnvelope(
        invoke: invoke,
        timeout: timeout,
        onTyped: MacosOcrException.new,
        mapNativeError: _mapNativeError,
        isTypedError: (error) => error is MacosOcrException,
      ).call(method, args);

  static Exception _mapNativeError(String code, String message) =>
      MacosOcrException(
        code,
        message,
        recoverable: recoverableCodes.contains(code),
      );
}
