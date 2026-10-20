import 'package:flutter/material.dart';

class ForYouTab extends StatelessWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF196653),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 22),
        children: [
          const _PlacesMosaic(),
          const SizedBox(height: 24),
          const Text(
            'Stories from places you love',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 27,
              height: 1.2,
              color: Colors.white,
              letterSpacing: -.3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Articles will appear based on your last viewed place. Visit the Places tab and select a location.',
            style: TextStyle(fontSize: 15, height: 1.5, color: Colors.white),
          ),
          const SizedBox(height: 28),
          Center(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on, size: 22),
              label: const Text(
                'Go to Places',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 14,
                ),
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlacesMosaic extends StatelessWidget {
  const _PlacesMosaic();
  static const _pyramids =
      'https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?w=700&h=500&fit=crop';
  static const _rio =
      'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?w=700&h=900&fit=crop';
  static const _museum =
      'https://images.unsplash.com/photo-1566139884669-6d7c77b6d2b0?w=700&h=700&fit=crop';
  static const _mountain =
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=700&h=600&fit=crop';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 365,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                const Expanded(flex: 8, child: _PlaceImage(url: _pyramids)),
                const SizedBox(height: 14),
                const Expanded(flex: 11, child: _PlaceImage(url: _museum)),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              children: [
                const Expanded(flex: 12, child: _PlaceImage(url: _rio)),
                const SizedBox(height: 14),
                const Expanded(flex: 8, child: _PlaceImage(url: _mountain)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  const _PlaceImage({required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox.expand(
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: const Color(0xFFB7C8C1),
            child: const Icon(Icons.landscape, size: 48, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
