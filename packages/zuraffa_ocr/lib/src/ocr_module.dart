/// A compiled WebAssembly module, bound to [id] inside the owning
/// engine/adapter until unloaded.
class OcrModule {
  final String id;
  final int byteLength;

  const OcrModule({required this.id, required this.byteLength});
}
