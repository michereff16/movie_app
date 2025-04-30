import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import '../view_models/movie_details_view_model.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/movie_grid.dart';
import 'info_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedLanguage = 'Português';
  final List<String> _languages = ['English', 'Português'];

  @override
  Widget build(BuildContext context) {
    // Access the ViewModel
    final viewModel = Provider.of<HomeViewModel>(context);
    final detailsViewModel = Provider.of<MovieDetailsViewModel>(
      context,
      listen: false,
    );

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
                        _buildAppBar(),
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
                        _buildTabBar(context, viewModel),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Idioma',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Image.asset('assets/location.png', height: 16),
                  const SizedBox(width: 4),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedLanguage,
                      items:
                          _languages.map((language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(language),
                            );
                          }).toList(),
                      onChanged: (selected) {
                        setState(() {
                          _selectedLanguage = selected!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/profile.png', height: 40),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabButton(context, 0, 'Nos cinemas', viewModel),
          const SizedBox(width: 16),
          _buildTabButton(context, 1, 'Em breve', viewModel),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    int index,
    String label,
    HomeViewModel viewModel,
  ) {
    final isSelected = viewModel.currentTabIndex == index;
    return GestureDetector(
      onTap: () {
        viewModel.setCurrentTabIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3498DB) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          gradient:
              isSelected
                  ? const LinearGradient(
                    colors: [Color(0xFF0E9FF3), Color(0xFF094B96)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                  : null,
          border:
              isSelected
                  ? const GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: [Color(0xFF005BB0), Color(0xFF0084FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  )
                  : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
