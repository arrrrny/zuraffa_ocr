/// zuraffa_ocr — Ocr support for the Zuraffa ecosystem.
///
/// A pure-Dart port (`OcrPort`), a facade (`OcrService`),
/// typed failures, and DI registration. Platform adapters implement the
/// port over an injected platform channel — the shared envelope machinery
/// lives in `zuraffa_ocr_platform`.
library;

export 'src/ocr_exception.dart';
export 'src/ocr_module.dart';
export 'src/ocr_port.dart';
export 'src/ocr_service.dart';
export 'src/ocr_value.dart';
