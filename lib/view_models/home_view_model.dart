import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/movie_service.dart';

class HomeViewModel extends ChangeNotifier {
  MovieService _movieService = MovieService();

  set movieService(MovieService movieService) {
    _movieService = movieService;
  }

  List<Movie> _featuredMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _comingSoonMovies = [];
  int _currentTabIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;

  // Getters
  List<Movie> get featuredMovies => _featuredMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get comingSoonMovies => _comingSoonMovies;
  int get currentTabIndex => _currentTabIndex;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Movie> get currentTabMovies =>
      _currentTabIndex == 0 ? _nowPlayingMovies : _comingSoonMovies;

  // Constructor
  HomeViewModel({bool skipLoading = false}) {
    if (!skipLoading) {
      _loadMovies();
    }
  }

  // Methods
  Future<void> _loadMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _featuredMovies = await _movieService.getFeaturedMovies();
      _nowPlayingMovies = await _movieService.getNowPlayingMovies();
      _comingSoonMovies = await _movieService.getComingSoonMovies();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load movies: ${e.toString()}';
      notifyListeners();
    }
  }

  void setCurrentTabIndex(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  Future<void> refreshMovies() async {
    await _loadMovies();
  }
}
