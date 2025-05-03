import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/view_models/movie_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MovieDetailsViewModel>(context);

    if (!viewModel.hasMovie) {
      return const Scaffold(body: Center(child: Text('No movie selected')));
    }

    final movie = viewModel.movie!;

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          _buildMoviePoster(context, movie.backdropUrl),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border(
                  top: BorderSide(color: Colors.white54, width: 2),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 320,
                    left: -92,
                    child: FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 200,
                      color: const Color(0xB6FF0000),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 275,
                    child: FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 200,
                      color: const Color(0x80FFEA00),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 65, sigmaY: 65),
                      child: Container(
                        color: Colors.deepPurple.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC60385),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '+18',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: size.width * 0.92,
                            child: Row(
                              children: [
                                Text(
                                  movie.originalTitle ?? 'Título original',
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                const Text(
                                  ' • ',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  movie.year,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildRating(
                            context,
                            movie.voteAverage,
                            movie.voteCount,
                          ),
                          const SizedBox(height: 16),
                          _buildGenres(movie.genres),
                          const SizedBox(height: 24),
                          _buildSummarySection(context, movie.overview),
                          const SizedBox(height: 24),
                          _buildDetailsSection(
                            context,
                            movie.releaseDate,
                            movie.country,
                            movie.budget.toString(),
                          ),
                          const SizedBox(height: 34),
                          _buildOfficialPageButton(context),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviePoster(BuildContext context, String movieBackdrop) {
    return Stack(
      children: [
        // Movie poster image
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
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
          top: MediaQuery.of(context).padding.top + 10,
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

  Widget _buildRating(BuildContext ctx, double rating, int votes) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 24),
        const SizedBox(width: 8),
        Text(
          rating.toString().substring(0, 3),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$votes ${AppLocalizations.of(ctx)!.votes}',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildGenres(List<String>? genres) {
    final genreList = genres ?? ['gênero 1', 'gênero 2'];
    return Text(
      genreList.join('; '),
      style: const TextStyle(
        color: Colors.white70,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildSummarySection(BuildContext ctx, String? summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(ctx)!.overview,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(summary ?? '[...]', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildDetailsSection(
    BuildContext ctx,
    String? releaseDate,
    String? country,
    String? budget,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(ctx)!.releaseDate,
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
            const SizedBox(height: 4),
            Text(
              releaseDate ?? '26/02/2024',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(ctx)!.countryOfOrigin,
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
            const SizedBox(height: 4),
            Text(
              country ?? 'China',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(ctx)!.budget,
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
            const SizedBox(height: 4),
            Text(
              budget ?? 'U\$ 120000',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOfficialPageButton(BuildContext context) {
    return InkWell(
      onTap: () {
        //Abre link do site oficial
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [const Color(0xFF3498DB), const Color(0xFF005BB0)],
          ),
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.officialPage,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
