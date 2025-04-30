import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();

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
  HomeViewModel() {
    _loadMovies();
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

  void refreshMovies() {
    _loadMovies();
  }
}
