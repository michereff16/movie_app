import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/view_models/movie_details_view_model.dart';
import 'package:movie_app/services/movie_service.dart';

class FakeMovieService extends MovieService {
  @override
  Future<Movie> getMovieDetails(String movieId) async {
    return Movie(
      id: int.parse(movieId),
      title: 'Test Movie',
      voteAverage: 8.5,
      voteCount: 1000,
      releaseDate: '2025-05-07',
      overview: 'This is a test movie.',
    );
  }
}

class FakeMovieServiceWithError extends MovieService {
  @override
  Future<Movie> getMovieDetails(String movieId) async {
    throw Exception('Failed to fetch movie details');
  }
}

void main() {
  late MovieDetailsViewModel viewModel;

  setUp(() {
    // Inject the FakeMovieService into MovieDetailsViewModel
    viewModel = MovieDetailsViewModel();
  });

  group('MovieDetailsViewModel Tests', () {
    test('initial state is correct', () {
      // Assert
      expect(viewModel.movie, isNull);
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.hasMovie, false);
    });

    test('loads movie details successfully', () async {
      // Arrange
      viewModel.movieService = FakeMovieService();

      // Act
      await viewModel.loadMovieDetails('1');

      // Assert
      expect(viewModel.isLoading, false);
      expect(viewModel.movie, isNotNull);
      expect(viewModel.movie?.title, 'Test Movie');
      expect(viewModel.errorMessage, isNull);
    });

    test('handles errors when loading movie details', () async {
      // Arrange
      viewModel.movieService = FakeMovieServiceWithError();

      // Act
      await viewModel.loadMovieDetails('1');

      // Assert
      expect(viewModel.isLoading, false);
      expect(viewModel.movie, isNull);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.errorMessage, contains('Failed to load movie details'));
    });

    test('sets movie manually', () {
      // Arrange
      final movie = Movie(
        id: 1,
        title: 'Manually Set Movie',
        voteAverage: 9.0,
        voteCount: 500,
        releaseDate: '2025-06-01',
        overview: 'This is a manually set movie.',
      );

      // Act
      viewModel.setMovie(movie);

      // Assert
      expect(viewModel.movie, isNotNull);
      expect(viewModel.movie?.title, 'Manually Set Movie');
      expect(viewModel.hasMovie, true);
    });

    test('clears movie details', () {
      // Arrange
      final movie = Movie(
        id: 1,
        title: 'Test Movie',
        voteAverage: 8.5,
        voteCount: 1000,
        releaseDate: '2025-05-07',
        overview: 'This is a test movie.',
      );
      viewModel.setMovie(movie);

      // Act
      viewModel.clearMovie();

      // Assert
      expect(viewModel.movie, isNull);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.hasMovie, false);
    });
  });
}
