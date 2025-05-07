import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/movie_service.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  MovieService _movieService = MovieService();

  set movieService(MovieService movieService) {
    _movieService = movieService;
  }

  Movie? _movie;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  Movie? get movie => _movie;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMovie => _movie != null;

  // Methods
  Future<void> loadMovieDetails(String movieId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movie = await _movieService.getMovieDetails(movieId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load movie details: ${e.toString()}';
      notifyListeners();
    }
  }

  void setMovie(Movie movie) {
    _movie = movie;
    notifyListeners();
  }

  void clearMovie() {
    _movie = null;
    _errorMessage = null;
    notifyListeners();
  }
}
