import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/view_models/home_view_model.dart';
import 'package:movie_app/services/movie_service.dart';

class FakeMovieService extends MovieService {
  @override
  Future<List<Movie>> getFeaturedMovies() async {
    return [
      Movie(id: 1, title: 'Featured Movie 1', voteAverage: 8.5, voteCount: 100),
      Movie(id: 2, title: 'Featured Movie 2', voteAverage: 7.5, voteCount: 200),
    ];
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    return [
      Movie(
        id: 3,
        title: 'Now Playing Movie 1',
        voteAverage: 9.0,
        voteCount: 300,
      ),
      Movie(
        id: 4,
        title: 'Now Playing Movie 2',
        voteAverage: 6.5,
        voteCount: 150,
      ),
    ];
  }

  @override
  Future<List<Movie>> getComingSoonMovies() async {
    return [
      Movie(
        id: 5,
        title: 'Coming Soon Movie 1',
        voteAverage: 8.0,
        voteCount: 250,
      ),
      Movie(
        id: 6,
        title: 'Coming Soon Movie 2',
        voteAverage: 7.0,
        voteCount: 180,
      ),
    ];
  }
}

void main() {
  late HomeViewModel homeViewModel;

  setUp(() {
    // Inject the FakeMovieService into HomeViewModel
    homeViewModel = HomeViewModel()..movieService = FakeMovieService();
  });
  group('HomeViewModel Tests', () {
    test('initial state isLoading is true', () {
      // Arrange
      homeViewModel = HomeViewModel(skipLoading: true);

      // Assert
      expect(homeViewModel.isLoading, true);
    });

    test('loads movies successfully', () async {
      // Act
      await homeViewModel.refreshMovies();

      // Assert
      expect(homeViewModel.isLoading, false);
      expect(homeViewModel.featuredMovies.length, 2);
      expect(homeViewModel.nowPlayingMovies.length, 2);
      expect(homeViewModel.comingSoonMovies.length, 2);
      expect(homeViewModel.errorMessage, isNull);
    });

    test('sets current tab index and updates currentTabMovies', () {
      // Act
      homeViewModel.setCurrentTabIndex(1);

      // Assert
      expect(homeViewModel.currentTabIndex, 1);
      expect(homeViewModel.currentTabMovies, homeViewModel.comingSoonMovies);
    });

    test('handles errors when loading movies', () async {
      // Arrange
      homeViewModel.movieService =
          FakeMovieServiceWithError(); // Use the setter here

      // Act
      await homeViewModel.refreshMovies();

      // Assert
      expect(homeViewModel.isLoading, false);
      expect(homeViewModel.errorMessage, isNotNull);
      expect(homeViewModel.featuredMovies.isEmpty, true);
      expect(homeViewModel.nowPlayingMovies.isEmpty, true);
      expect(homeViewModel.comingSoonMovies.isEmpty, true);
    });
  });
}

class FakeMovieServiceWithError extends MovieService {
  @override
  Future<List<Movie>> getFeaturedMovies() async {
    throw Exception('Failed to fetch featured movies');
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    throw Exception('Failed to fetch now playing movies');
  }

  @override
  Future<List<Movie>> getComingSoonMovies() async {
    throw Exception('Failed to fetch coming soon movies');
  }
}
