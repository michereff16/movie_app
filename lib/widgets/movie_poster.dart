import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MoviePosterWidget extends StatelessWidget {
  const MoviePosterWidget({super.key, required this.movieBackdrop});

  final String movieBackdrop;

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          height: spacing.size.height * 0.45,
          width: double.infinity,
          color: Colors.white10,
          child: CachedNetworkImage(
            imageUrl: movieBackdrop,
            fit: BoxFit.cover,
            placeholder:
                (context, url) =>
                    const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            filterQuality: FilterQuality.high,
          ),
        ),

        // Back button
        Positioned(
          top: spacing.padding.top + 10,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),

        // Play button
        Positioned.fill(
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black45,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
