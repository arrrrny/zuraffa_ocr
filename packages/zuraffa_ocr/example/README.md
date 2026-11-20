# zuraffa_ocr

Optical character recognition plugin for Zuraffa/Flutter — extract text from
images using the platform's native OCR engine.

## Recognize text in an image

```dart
import 'package:flutter/material.dart';
import 'package:zuraffa_ocr/zuraffa_ocr.dart';

Future<void> scanImage() async {
  final result = await ZuraffaOcr.recognizeText(imagePath: '/tmp/scan.png');
  for (final block in result.blocks) {
    debugPrint(block.text);
  }
}
```

## Check availability

```dart
import 'package:zuraffa_ocr/zuraffa_ocr.dart';

final available = await ZuraffaOcr.isAvailable();
```