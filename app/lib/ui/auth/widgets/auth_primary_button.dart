import 'package:flutter/material.dart';

/// Tombol aksi utama yang digunakan di layar Login dan Register.
/// Sesuai instruksi: light mode dan tanpa warna biru (menggunakan warna gelap/charcoal khas Wikipedia).
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    // Warna default gelap/charcoal murni khas Wikipedia minimalis (bukan biru)
    const defaultBg = Color(0xFF202122);
    const defaultFg = Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? defaultBg,
          foregroundColor: foregroundColor ?? defaultFg,
          disabledBackgroundColor: const Color(0xFFE2E5E8),
          disabledForegroundColor: const Color(0xFF8B929A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // Pill-shaped sesuai screenshot
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(label),
      ),
    );
  }
}
