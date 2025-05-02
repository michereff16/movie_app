class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '90c0becf748741b8b4387e86c928c707';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  // Endpoints
  static const String topRatedEndpoint = '/movie/top_rated';
  static const String nowPlayingEndpoint = '/movie/now_playing';
  static const String upcomingEndpoint = '/movie/upcoming';
  static const String movieDetailsEndpoint = '/movie/';
  // Parameters
  static const String apiKeyParam = 'api_key';
  static const String languageParam = 'language';
  static const String pageParam = 'page';

  // Default values
  static const String defaultLanguage = 'pt-BR';
  static const int defaultPage = 1;
}
