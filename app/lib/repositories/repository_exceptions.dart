/// Dilempar repository saat API menjawab 401 (belum masuk / token kedaluwarsa).
/// UI memakainya untuk menampilkan ajakan masuk, bukan pesan galat umum.
class UnauthorizedException implements Exception {
  const UnauthorizedException();

  @override
  String toString() => 'Kamu perlu masuk untuk melakukan ini.';
}
