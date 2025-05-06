import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/models/movie.dart';

class ApiService {
  Future<Map<String, String>> _getHeaders() async {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParams) {
    final params = {
      ApiConstants.apiKeyParam: dotenv.env['API_KEY'],
      ApiConstants.languageParam: ApiConstants.defaultLanguage,
      ...?queryParams,
    };

    return Uri.parse('${ApiConstants.baseUrl}$endpoint').replace(
      queryParameters: params.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      final headers = await _getHeaders();

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Movie>> getMovieList(String endpoint, {int page = 1}) async {
    try {
      final data = await get(
        endpoint,
        queryParams: {ApiConstants.pageParam: page},
      );

      if (data != null && data['results'] != null) {
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Invalid data format');
      }
    } catch (e) {
      throw Exception('Failed to get movies: $e');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final data = await get('${ApiConstants.movieDetailsEndpoint}$movieId');

      if (data != null) {
        return Movie.fromJson(data);
      } else {
        throw Exception('Invalid data format');
      }
    } catch (e) {
      throw Exception('Failed to get movie details: $e');
    }
  }

  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    return getMovieList(ApiConstants.topRatedEndpoint, page: page);
  }

  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    return getMovieList(ApiConstants.nowPlayingEndpoint, page: page);
  }

  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    return getMovieList(ApiConstants.upcomingEndpoint, page: page);
  }
}
