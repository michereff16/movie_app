import '../models/movie.dart';

class MovieService {
  // In a real app, this would make API calls to a backend service
  // For this example, we'll use mock data

  Future<List<Movie>> getFeaturedMovies() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      Movie(
        id: '1',
        title: 'Harry Potter',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 8.2,
        votes: 120,
      ),
      Movie(
        id: '2',
        title: 'Batman',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 8.5,
        votes: 150,
      ),
      Movie(
        id: '3',
        title: 'La La Land',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 7.9,
        votes: 110,
      ),
    ];
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      Movie(
        id: '4',
        title: 'Insidious',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 7.2,
        votes: 90,
      ),
      Movie(
        id: '5',
        title: 'Câm',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 5.3,
        votes: 90,
      ),
      Movie(
        id: '6',
        title: 'Fast 20',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 2.2,
        votes: 90,
      ),
    ];
  }

  Future<List<Movie>> getComingSoonMovies() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      Movie(
        id: '7',
        title: 'Coming Soon 1',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 0.0,
        votes: 0,
      ),
      Movie(
        id: '8',
        title: 'Coming Soon 2',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 0.0,
        votes: 0,
      ),
    ];
  }

  Future<Movie> getMovieDetails(String movieId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // In a real app, we would fetch the specific movie by ID
    // For this example, we'll return a mock movie with details
    if (movieId == '5') {
      return Movie(
        id: '5',
        title: 'Câm',
        originalTitle: 'Título original',
        posterUrl: 'https://placeholder.com/300x450',
        rating: 5.3,
        votes: 90,
        releaseDate: '26/02/2024',
        country: 'China',
        budget: 'U\$ 120000',
        genres: ['gênero 1', 'gênero 2'],
        summary: '[...]',
        ageRating: '+18',
        year: '2024',
      );
    }

    // Default movie details
    return Movie(
      id: movieId,
      title: 'Movie $movieId',
      originalTitle: 'Original Title',
      posterUrl: 'https://placeholder.com/300x450',
      rating: 7.5,
      votes: 100,
      releaseDate: '01/01/2024',
      country: 'USA',
      budget: 'U\$ 100000',
      genres: ['Action', 'Drama'],
      summary: 'Movie summary goes here...',
      ageRating: '+16',
      year: '2024',
    );
  }
}
