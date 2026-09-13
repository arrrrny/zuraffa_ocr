import 'dart:typed_data';

import 'ocr_module.dart';
import 'ocr_value.dart';

/// The platform-neutral port every adapter implements. Pure Dart — the
/// transport is injected behind the platform envelope, so tests run
/// offline with fake channels.
abstract class OcrPort {
  const OcrPort();

  /// Whether the host platform can run WebAssembly at all.
  Future<bool> isSupported();

  /// Compiles [bytes] and binds the result to [id].
  Future<OcrModule> compile({
    required String id,
    required Uint8List bytes,
  });

  /// Invokes [export] on the compiled module [id].
  Future<List<OcrValue>> invoke({
    required String id,
    required String export,
    List<OcrValue> args = const [],
  });

  /// Releases the compiled module [id].
  Future<void> unload({required String id});
}
