import 'dart:typed_data';

import 'package:zuraffa_ocr/zuraffa_ocr.dart';

import 'android_ocr_channel.dart';
import 'android_ocr_exception.dart';

/// Android [OcrPort] over the typed
/// [AndroidOcrChannel].
class AndroidOcrPort implements OcrPort {
  final AndroidOcrChannel channel;

  const AndroidOcrPort({required this.channel});

  @override
  Future<bool> isSupported() async {
    final result = await channel.call('isSupported', const {});
    return result?['supported'] == true;
  }

  @override
  Future<OcrModule> compile({
    required String id,
    required Uint8List bytes,
  }) async {
    final result = await channel.call('compile', {
      'id': id,
      'bytes': bytes,
    });
    return OcrModule(
      id: id,
      byteLength:
          (result?['byteLength'] as num?)?.toInt() ?? bytes.lengthInBytes,
    );
  }

  @override
  Future<List<OcrValue>> invoke({
    required String id,
    required String export,
    List<OcrValue> args = const [],
  }) async {
    final result = await channel.call('invoke', {
      'id': id,
      'export': export,
      'args': [for (final arg in args) arg.encode()],
    });
    final values = result?['values'];
    if (values is! List) {
      throw const AndroidOcrException(
        'malformed_response',
        'The invoke result carried no value list.',
        recoverable: false,
      );
    }
    return [for (final raw in values) OcrValue.decode(raw)];
  }

  @override
  Future<void> unload({required String id}) async {
    await channel.call('unload', {'id': id});
  }
}
