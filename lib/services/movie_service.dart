import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/api_service.dart';

class MovieService {
  final ApiService _apiService = ApiService();

  Future<List<Movie>> getFeaturedMovies() async {
    try {
      return await _apiService.getTopRatedMovies();
    } catch (e) {
      throw Exception('Failed to get featured movies: $e');
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      return await _apiService.getNowPlayingMovies();
    } catch (e) {
      throw Exception('Failed to get now playing movies: $e');
    }
  }

  Future<List<Movie>> getComingSoonMovies() async {
    try {
      return await _apiService.getUpcomingMovies();
    } catch (e) {
      throw Exception('Failed to get upcoming movies: $e');
    }
  }

  Future<Movie> getMovieDetails(String movieId) async {
    try {
      return await _apiService.getMovieDetails(int.parse(movieId));
    } catch (e) {
      throw Exception('Failed to get movie details: $e');
    }
  }
}
