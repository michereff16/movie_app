import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/view_models/movie_details_view_model.dart';
import 'package:movie_app/widgets/details_section.dart';
import 'package:movie_app/widgets/genres.dart';
import 'package:movie_app/widgets/official_page_button.dart';
import 'package:movie_app/widgets/rating.dart';
import 'package:movie_app/widgets/summary_section.dart';
import 'package:movie_app/widgets/movie_poster.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MovieDetailsViewModel>(context);

    if (!viewModel.hasMovie) {
      return Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.nA)),
      );
    }

    final movie = viewModel.movie!;

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          MoviePosterWidget(movieBackdrop: movie.backdropUrl),
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
                                  movie.originalTitle ??
                                      AppLocalizations.of(context)!.nA,
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
                          RatingWidget(
                            rating: movie.voteAverage,
                            votes: movie.voteCount,
                          ),
                          const SizedBox(height: 16),
                          GenresWidget(genres: movie.genres),
                          const SizedBox(height: 24),
                          SummarySectionWidget(summary: movie.overview),
                          const SizedBox(height: 24),
                          DetailsSectionWidget(
                            releaseDate: movie.formattedReleaseDate,
                            country: movie.country,
                            budget: movie.formattedBudget.toString(),
                          ),
                          const SizedBox(height: 34),
                          OfficialPageButtonWidget(
                            buttonTitle:
                                AppLocalizations.of(context)!.officialPage,
                            officialPageUrl: 'https://www.google.com',
                          ),
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
}
