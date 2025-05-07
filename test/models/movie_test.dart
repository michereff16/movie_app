import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/models/movie.dart';

void main() {
  group('Movie Model Tests', () {
    late Movie movie;

    setUp(() {
      movie = Movie(
        id: 1,
        title: 'Test Movie',
        originalTitle: 'Original Test Movie',
        posterPath: '/poster.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 8.5,
        voteCount: 1000,
        releaseDate: '2025-05-07',
        overview: 'This is a test movie.',
        genres: ['Action', 'Drama'],
        originalLanguage: 'en',
        popularity: 99.9,
        status: 'Released',
        budget: 1000000,
        revenue: 5000000,
        runtime: 120,
      );
    });

    test('posterUrl returns correct URL', () {
      expect(movie.posterUrl, '${ApiConstants.imageBaseUrl}/poster.jpg');
    });

    test('backdropUrl returns correct URL', () {
      expect(movie.backdropUrl, '${ApiConstants.imageBaseUrl}/backdrop.jpg');
    });

    test('year returns correct year from releaseDate', () {
      expect(movie.year, '2025');
    });

    test('formattedReleaseDate returns correctly formatted date', () {
      expect(movie.formattedReleaseDate, '07/05/2025');
    });

    test('formattedReleaseDate returns empty string for null releaseDate', () {
      final movieWithNullDate = Movie(
        id: 1,
        title: 'Test Movie',
        voteAverage: 8.5,
        voteCount: 1000,
      );
      expect(movieWithNullDate.formattedReleaseDate, '');
    });

    test('ageRating returns "N/A"', () {
      expect(movie.ageRating, 'N/A');
    });

    test('country returns correct country based on originalLanguage', () {
      expect(movie.country, 'USA');
    });

    test('formattedBudget returns formatted budget', () {
      expect(movie.formattedBudget, 'U\$ 1000000');
    });

    test('formattedBudget returns "N/A" for null or zero budget', () {
      final movieWithNoBudget = Movie(
        id: 1,
        title: 'Test Movie',
        voteAverage: 8.5,
        voteCount: 1000,
        budget: 0,
      );
      expect(movieWithNoBudget.formattedBudget, 'N/A');
    });

    test('fromJson creates Movie instance from JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Movie',
        'original_title': 'Original Test Movie',
        'poster_path': '/poster.jpg',
        'backdrop_path': '/backdrop.jpg',
        'vote_average': 8.5,
        'vote_count': 1000,
        'release_date': '2025-05-07',
        'overview': 'This is a test movie.',
        'genres': [
          {'name': 'Action'},
          {'name': 'Drama'}
        ],
        'original_language': 'en',
        'popularity': 99.9,
        'status': 'Released',
        'budget': 1000000,
        'revenue': 5000000,
        'runtime': 120,
      };

      final movieFromJson = Movie.fromJson(json);

      expect(movieFromJson.id, 1);
      expect(movieFromJson.title, 'Test Movie');
      expect(movieFromJson.originalTitle, 'Original Test Movie');
      expect(movieFromJson.posterPath, '/poster.jpg');
      expect(movieFromJson.backdropPath, '/backdrop.jpg');
      expect(movieFromJson.voteAverage, 8.5);
      expect(movieFromJson.voteCount, 1000);
      expect(movieFromJson.releaseDate, '2025-05-07');
      expect(movieFromJson.overview, 'This is a test movie.');
      expect(movieFromJson.genres, ['Action', 'Drama']);
      expect(movieFromJson.originalLanguage, 'en');
      expect(movieFromJson.popularity, 99.9);
      expect(movieFromJson.status, 'Released');
      expect(movieFromJson.budget, 1000000);
      expect(movieFromJson.revenue, 5000000);
      expect(movieFromJson.runtime, 120);
    });
  });
}