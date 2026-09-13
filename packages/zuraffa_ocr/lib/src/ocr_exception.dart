/// The typed failure surfaced by the zuraffa_ocr port and service.
class OcrException implements Exception {
  final String code;
  final String message;
  final bool recoverable;

  const OcrException(
    this.code,
    this.message, {
    required this.recoverable,
  });

  @override
  String toString() =>
      'OcrException($code, recoverable: $recoverable): $message';
}
