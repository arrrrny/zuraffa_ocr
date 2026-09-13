/// The typed native failure on macOS.
class MacosOcrException implements Exception {
  final String code;
  final String message;
  final bool recoverable;

  const MacosOcrException(
    this.code,
    this.message, {
    required this.recoverable,
  });

  @override
  String toString() =>
      'MacosOcrException($code, recoverable: $recoverable): $message';
}
