import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/neon_painter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeaturedCarousel extends StatefulWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieTap;

  const FeaturedCarousel({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  final CarouselSliderController _buttonCarouselController =
      CarouselSliderController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.movies.length,
          itemBuilder:
              (context, index, realIndex) => GestureDetector(
                onTap: () => widget.onMovieTap(widget.movies[index]),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: CustomPaint(
                    painter: NeonPainter(),
                    child: Container(
                      width: size.width * 0.46,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: CachedNetworkImage(
                          imageUrl: widget.movies[index].posterUrl,
                          fit: BoxFit.fill,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          options: CarouselOptions(
            height: size.height * 0.316,
            autoPlay: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            viewportFraction: 0.49,
            onPageChanged:
                (index, reason) => setState(() {
                  _currentPage = index;
                }),
          ),
          carouselController: _buttonCarouselController,
        ),
        const SizedBox(height: 12),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.movies.length,
        (index) => Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index ? const Color(0xFFC60385) : Colors.white,
          ),
        ),
      ),
    );
  }
}
