import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

class OnboardingImage extends StatelessWidget {
  final String imageUrl;

  const OnboardingImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(
      url: imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, progress) =>
          const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, url, error) => const Icon(Icons.error),
    );
  }
}
