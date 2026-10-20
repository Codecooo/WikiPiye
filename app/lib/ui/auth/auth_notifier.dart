import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wikipiye/models/dto/dto.dart';
import 'package:wikipiye/repositories/auth_repository.dart';
import 'package:wikipiye/services/api_service.dart';

part 'auth_notifier.g.dart';

// ── State ──────────────────────────────────────────────────────────────────────

/// State autentikasi aplikasi.
sealed class AuthState {
  const AuthState();
}

/// Belum diketahui apakah user sudah login atau belum (saat splash screen).
class AuthStateUnknown extends AuthState {
  const AuthStateUnknown();
}

/// User belum login.
class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

/// User sudah login. Menyimpan data user dari server.
class AuthStateAuthenticated extends AuthState {
  final AuthUserDTO user;
  const AuthStateAuthenticated(this.user);
}

// ── Notifier ───────────────────────────────────────────────────────────────────

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = AuthRepository(ref.watch(apiServiceProvider));
    // Cek sesi aktif saat notifier pertama kali dibuat
    _checkActiveSession();
    return const AuthStateUnknown();
  }

  // ── Pengecekan Sesi ──────────────────────────────────────────────────────

  Future<void> _checkActiveSession() async {
    final user = await _authRepository.getStoredUser();
    if (user != null) {
      state = AuthStateAuthenticated(user);
    } else {
      state = const AuthStateUnauthenticated();
    }
  }

  // ── Login ────────────────────────────────────────────────────────────────

  Future<void> login(String username, String password) async {
    final dto = LoginRequestDTO(username: username, password: password);
    final user = await _authRepository.login(dto);
    state = AuthStateAuthenticated(user);
  }

  // ── Register ─────────────────────────────────────────────────────────────

  /// Mendaftarkan user baru. Melempar [Exception] jika gagal.
  /// Tidak otomatis login setelah register (user harus login sendiri).
  Future<String> register({
    required String username,
    required String email,
    required String password,
    String firstName = '',
    String lastName = '',
  }) async {
    final dto = RegisterRequestDTO(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    return _authRepository.register(dto);
  }

  // ── Logout ───────────────────────────────────────────────────────────────

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthStateUnauthenticated();
  }
}
