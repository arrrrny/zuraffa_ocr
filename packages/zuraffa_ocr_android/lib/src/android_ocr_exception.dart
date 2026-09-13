/// The typed native failure on Android.
class AndroidOcrException implements Exception {
  final String code;
  final String message;
  final bool recoverable;

  const AndroidOcrException(
    this.code,
    this.message, {
    required this.recoverable,
  });

  @override
  String toString() =>
      'AndroidOcrException($code, recoverable: $recoverable): $message';
}
