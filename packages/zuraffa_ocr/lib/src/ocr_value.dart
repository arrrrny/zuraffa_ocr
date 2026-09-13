import 'ocr_exception.dart';

/// A WebAssembly scalar value crossing the platform boundary.
///
/// The scaffold ships the four numeric types; the migration extends the
/// family (reference types, vectors) without breaking the contract.
sealed class OcrValue {
  const OcrValue();

  /// Encodes this value into the primitive representation transported over
  /// the platform channel. i64 travels as a decimal string — channel
  /// payloads cannot carry a BigInt losslessly.
  Object encode() => switch (this) {
        OcrI32(:final value) => value,
        OcrI64(:final value) => value.toString(),
        OcrF32(:final value) => value,
        OcrF64(:final value) => value,
      };

  /// Decodes a channel payload into a [OcrValue]: ints decode as
  /// i32, doubles as f64, and decimal strings as i64.
  static OcrValue decode(Object? raw) {
    if (raw is int) return OcrI32(raw);
    if (raw is double) return OcrF64(raw);
    if (raw is String) {
      final parsed = BigInt.tryParse(raw);
      if (parsed != null) return OcrI64(parsed);
    }
    throw OcrException(
      'malformed_value',
      'Cannot decode "$raw" into a OcrValue.',
      recoverable: false,
    );
  }
}

/// A 32-bit integer value.
class OcrI32 extends OcrValue {
  final int value;

  const OcrI32(this.value);
}

/// A 64-bit integer value (transported as a decimal string).
class OcrI64 extends OcrValue {
  final BigInt value;

  const OcrI64(this.value);
}

/// A 32-bit float value.
class OcrF32 extends OcrValue {
  final double value;

  const OcrF32(this.value);
}

/// A 64-bit float value.
class OcrF64 extends OcrValue {
  final double value;

  const OcrF64(this.value);
}
