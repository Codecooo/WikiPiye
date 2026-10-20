import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/auth/auth_notifier.dart';
import 'package:wikipiye/ui/auth/register_screen.dart';
import 'package:wikipiye/ui/auth/widgets/auth_primary_button.dart';
import 'package:wikipiye/ui/auth/widgets/auth_secondary_button.dart';
import 'package:wikipiye/ui/auth/widgets/auth_text_field.dart';
import 'package:wikipiye/ui/auth/widgets/auth_zoom_controls.dart';
import 'package:wikipiye/ui/home/home_screen.dart';

/// Layar Login WikiPiye.
/// Mengikuti tampilan resmi Wikipedia mobile dalam versi Light Mode:
/// - AppBar bersih dengan tombol back dan kontrol zoom (+ dan -)
/// - Input Username dan Password
/// - Tombol utama "Log in" pill-shaped berwarna gelap netral (bukan biru)
/// - Pembatas "Don't have an account?"
/// - Tombol sekunder "Join WikiPiye" abu-abu netral
/// - Tautan footer "Forgot your password? • Privacy policy"
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authProvider.notifier).login(
            _usernameController.text.trim(),
            _passwordController.text,
          );

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
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
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: const Text(
          'Log in',
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
                  autofillHints: const [AutofillHints.username],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username tidak boleh kosong';
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
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onFieldSubmitted: (_) => _onLoginPressed(),
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
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ── Tombol Log in (Tanpa warna biru) ──────────────────────
                AuthPrimaryButton(
                  label: 'Log in',
                  onPressed: _onLoginPressed,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 28),

                // ── Prompt Akun Baru ──────────────────────────────────────
                const Center(
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF54595D),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Tombol Join WikiPiye (Sekunder) ───────────────────────
                AuthSecondaryButton(
                  label: 'Join WikiPiye',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Footer Links ──────────────────────────────────────────
                const _AuthFooterLinks(),
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

class _AuthFooterLinks extends StatelessWidget {
  const _AuthFooterLinks();

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
