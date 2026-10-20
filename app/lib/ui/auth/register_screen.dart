import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/auth/auth_notifier.dart';
import 'package:wikipiye/ui/auth/widgets/auth_primary_button.dart';
import 'package:wikipiye/ui/auth/widgets/auth_secondary_button.dart';
import 'package:wikipiye/ui/auth/widgets/auth_text_field.dart';
import 'package:wikipiye/ui/auth/widgets/auth_zoom_controls.dart';

/// Layar Registrasi / Buat Akun WikiPiye.
/// Mengikuti tampilan resmi Wikipedia mobile "Create an account" versi Light Mode:
/// - AppBar bersih dengan judul "Create an account" dan kontrol zoom (+ dan -)
/// - Input Username, Password, Repeat password, Email (Optional)
/// - Keterangan pembantu "Recommended since email is needed for account recovery."
/// - Tombol utama "Next" berwarna gelap netral (bukan biru)
/// - Pembatas "Already have an account?"
/// - Tombol sekunder "Log in"
/// - Catatan hCaptcha & Privacy policy
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onRegisterPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final inputEmail = _emailController.text.trim();
    final finalEmail =
        inputEmail.isNotEmpty ? inputEmail : '$username@wikipiye.org';

    try {
      final message = await ref.read(authProvider.notifier).register(
            username: username,
            email: finalEmail,
            password: _passwordController.text,
            firstName: '',
            lastName: '',
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFF202122),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF202122),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF202122)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create an account',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF202122),
            letterSpacing: -0.4,
          ),
        ),
        actions: const [
          AuthZoomControls(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // ── Error Banner ──────────────────────────────────────────
                if (_errorMessage != null)
                  _ErrorBanner(message: _errorMessage!),

                // ── Username ──────────────────────────────────────────────
                AuthTextField(
                  controller: _usernameController,
                  label: 'Username',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newUsername],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    if (value.trim().length < 3) {
                      return 'Username minimal 3 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // ── Password ──────────────────────────────────────────────
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF72777D),
                      size: 22,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 8) {
                      return 'Password minimal 8 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // ── Repeat Password ───────────────────────────────────────
                AuthTextField(
                  controller: _confirmPasswordController,
                  label: 'Repeat password',
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF72777D),
                      size: 22,
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi password tidak boleh kosong';
                    }
                    if (value != _passwordController.text) {
                      return 'Password tidak cocok';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // ── Email (Optional) ──────────────────────────────────────
                AuthTextField(
                  controller: _emailController,
                  label: 'Email (Optional)',
                  helperText:
                      'Recommended since email is needed for account recovery.',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.email],
                  onFieldSubmitted: (_) => _onRegisterPressed(),
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Format email tidak valid';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ── Tombol Utama: Next (Tanpa warna biru) ─────────────────
                AuthPrimaryButton(
                  label: 'Next',
                  onPressed: _onRegisterPressed,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 28),

                // ── Prompt Sudah Punya Akun ────────────────────────────────
                const Center(
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF54595D),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Tombol Sekunder: Log in ───────────────────────────────
                AuthSecondaryButton(
                  label: 'Log in',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 24),

                // ── Disclaimer hCaptcha ───────────────────────────────────
                const Center(
                  child: Text(
                    'This site is protected by hCaptcha and its\nPrivacy Policy and Terms of Service apply.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF72777D),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Footer Links ──────────────────────────────────────────
                const _RegisterFooterLinks(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Sub-Widget ──────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        border: Border.all(color: const Color(0xFFB32424)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFB32424), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFFB32424),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterFooterLinks extends StatelessWidget {
  const _RegisterFooterLinks();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Silakan hubungi administrator WikiPiye untuk pemulihan akun.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Text(
                'Forgot your password?',
                style: TextStyle(
                  color: Color(0xFF54595D),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '•',
              style: TextStyle(
                color: Color(0xFF72777D),
                fontSize: 13,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Kebijakan Privasi WikiPiye: Menjamin perlindungan data pembaca dan kontributor.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: Text(
                'Privacy policy',
                style: TextStyle(
                  color: Color(0xFF54595D),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
