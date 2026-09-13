/// The typed native failure on iOS.
class IosOcrException implements Exception {
  final String code;
  final String message;
  final bool recoverable;

  const IosOcrException(
    this.code,
    this.message, {
    required this.recoverable,
  });

  @override
  String toString() =>
      'IosOcrException($code, recoverable: $recoverable): $message';
}
