import 'dart:typed_data';

import 'package:zuraffa/zuraffa.dart';

import 'ocr_exception.dart';
import 'ocr_module.dart';
import 'ocr_port.dart';
import 'ocr_value.dart';

/// Facade over the [OcrPort]: owns the compiled-module registry
/// and turns lifecycle mistakes (double compile, call-before-compile)
/// into typed failures before they reach the platform.
class OcrService {
  final OcrPort port;
  final Map<String, OcrModule> _modules = {};

  OcrService({required this.port});

  /// The compiled modules currently held by this service.
  Set<String> get compiledModules => Set.unmodifiable(_modules.keys);

  Future<bool> supported() => port.isSupported();

  Future<OcrModule> compile({
    required String id,
    required Uint8List bytes,
  }) async {
    if (_modules.containsKey(id)) {
      throw OcrException(
        'already_compiled',
        'Module "$id" is already compiled — unload it first.',
        recoverable: false,
      );
    }
    final module = await port.compile(id: id, bytes: bytes);
    _modules[id] = module;
    return module;
  }

  Future<List<OcrValue>> call({
    required String id,
    required String export,
    List<OcrValue> args = const [],
  }) async {
    _requireCompiled(id);
    return port.invoke(id: id, export: export, args: args);
  }

  Future<void> unload({required String id}) async {
    _requireCompiled(id);
    await port.unload(id: id);
    _modules.remove(id);
  }

  void _requireCompiled(String id) {
    if (!_modules.containsKey(id)) {
      throw OcrException(
        'not_compiled',
        'Module "$id" is not compiled — call compile() first.',
        recoverable: false,
      );
    }
  }
}

/// A port placeholder registered when no platform adapter was wired:
/// every operation surfaces the typed `port_not_wired` failure instead of
/// a null dereference at resolve time.
class _UnwiredOcrPort implements OcrPort {
  const _UnwiredOcrPort();

  Never _unwired() => throw const OcrException(
        'port_not_wired',
        'No OcrPort was registered — wire the platform adapter '
        'for the running platform before resolving OcrService.',
        recoverable: false,
      );

  @override
  Future<bool> isSupported() async => _unwired();

  @override
  Future<OcrModule> compile({
    required String id,
    required Uint8List bytes,
  }) =>
      _unwired();

  @override
  Future<List<OcrValue>> invoke({
    required String id,
    required String export,
    List<OcrValue> args = const [],
  }) =>
      _unwired();

  @override
  Future<void> unload({required String id}) => _unwired();
}

/// Registers the zuraffa_ocr stack onto [getIt]: the [OcrPort] is
/// normally supplied by the platform adapter package for the running
/// platform (e.g. `registerAndroidOcrDependencies`), so the
/// service falls back to the GetIt-registered port when no explicit one
/// is passed. Without any registered port the service resolves over the
/// unwired placeholder and surfaces typed `port_not_wired` failures.
void registerOcrDependencies(
  GetIt getIt, {
  OcrPort? port,
}) {
  getIt.registerLazySingleton<OcrService>(
    () => OcrService(
      port:
          port ??
          (getIt.isRegistered<OcrPort>()
              ? getIt<OcrPort>()
              : const _UnwiredOcrPort()),
    ),
  );
}
