import 'package:flutter/material.dart';

/// Kontrol zoom font (+ dan -) khas Wikipedia mobile di pojok kanan atas.
/// Didesain sesuai dengan antarmuka asli aplikasi Wikipedia.
class AuthZoomControls extends StatelessWidget {
  const AuthZoomControls({
    super.key,
    this.onZoomIn,
    this.onZoomOut,
  });

  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CircleZoomButton(
            icon: Icons.add,
            tooltip: 'Perbesar teks',
            onTap: onZoomIn,
          ),
          const SizedBox(height: 3),
          _CircleZoomButton(
            icon: Icons.remove,
            tooltip: 'Perkecil teks',
            onTap: onZoomOut,
          ),
        ],
      ),
    );
  }
}

class _CircleZoomButton extends StatelessWidget {
  const _CircleZoomButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: const Color(0xFFE8ECEF), // Abu-abu netral Wikipedia (tanpa biru)
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap ?? () {},
          child: SizedBox(
            width: 26,
            height: 26,
            child: Icon(
              icon,
              size: 16,
              color: const Color(0xFF202122),
            ),
          ),
        ),
      ),
    );
  }
}
