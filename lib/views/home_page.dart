import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import 'package:movie_app/services/locale.dart';
import 'package:movie_app/view_models/home_view_model.dart';
import 'package:movie_app/view_models/movie_details_view_model.dart';
import 'package:movie_app/widgets/featured_carousel.dart';
import 'package:movie_app/widgets/movie_grid.dart';
import 'package:movie_app/widgets/tab_bar.dart';

import 'info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Access the ViewModel
    final viewModel = Provider.of<HomeViewModel>(context);
    final detailsViewModel = Provider.of<MovieDetailsViewModel>(
      context,
      listen: false,
    );

    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale ?? const Locale('pt');

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child:
            viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.errorMessage != null
                ? Center(child: Text(viewModel.errorMessage!))
                : Stack(
                  children: [
                    Positioned(
                      top: 124,
                      left: -95,
                      child: FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 200,
                        color: const Color(0xFF00D9FF),
                      ),
                    ),
                    Positioned(
                      top: 659,
                      left: -72,
                      child: FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 200,
                        color: const Color(0xB6FF0000),
                      ),
                    ),
                    Positioned(
                      top: 393,
                      left: 275,
                      child: FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 200,
                        color: const Color(0x80FFEA00),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 65, sigmaY: 65),
                      child: Container(
                        color: Colors.deepPurple.withValues(alpha: 0.3),
                      ),
                    ),
                    Column(
                      children: [
                        AppBarWidget(
                          localeProvider: localeProvider,
                          currentLocale: currentLocale,
                        ),
                        FeaturedCarousel(
                          movies: viewModel.featuredMovies,
                          onMovieTap: (movie) {
                            detailsViewModel.setMovie(movie);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InfoPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        TabBarWidget(viewModel: viewModel),
                        Expanded(
                          child: MovieGrid(
                            movies: viewModel.currentTabMovies,
                            onMovieTap: (movie) {
                              detailsViewModel.setMovie(movie);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InfoPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
}
