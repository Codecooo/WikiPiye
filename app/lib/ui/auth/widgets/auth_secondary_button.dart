import 'package:flutter/material.dart';

/// Tombol aksi sekunder (seperti "Join WikiPiye", "Log in") di layar autentikasi.
/// Didesain dengan latar netral abu-abu terang (tanpa warna biru) dan bentuk kapsul (pill shape)
/// sesuai dengan antarmuka Wikipedia mobile.
class AuthSecondaryButton extends StatelessWidget {
  const AuthSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFEFEFF2), // Abu-abu lembut netral
          foregroundColor: const Color(0xFF202122), // Warna teks arang/charcoal
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // Bentuk kapsul / pill
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
