import 'package:movie_app/constants/api_constants.dart';

class Movie {
  final int id;
  final String title;
  final String? originalTitle;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String? releaseDate;
  final String? overview;
  final List<String>? genres;
  final String? originalLanguage;
  final double? popularity;
  final String? status;
  final int? budget;
  final int? revenue;
  final int? runtime;

  Movie({
    required this.id,
    required this.title,
    this.originalTitle,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
    this.overview,
    this.genres,
    this.originalLanguage,
    this.popularity,
    this.status,
    this.budget,
    this.revenue,
    this.runtime,
  });

  String get posterUrl =>
      posterPath != null ? '${ApiConstants.imageBaseUrl}$posterPath' : '';

  String get backdropUrl =>
      backdropPath != null ? '${ApiConstants.imageBaseUrl}$backdropPath' : '';

  String get year =>
      releaseDate != null && releaseDate!.length >= 4
          ? releaseDate!.substring(0, 4)
          : '';

  String get formattedReleaseDate {
    if (releaseDate == null || releaseDate!.isEmpty) return '';

    try {
      final parts = releaseDate!.split('-');
      if (parts.length == 3) {
        return '${parts[2]}/${parts[1]}/${parts[0]}';
      }
    } catch (e) {
      // Return original if parsing fails
    }

    return releaseDate!;
  }

  String get ageRating => 'N/A'; // This would come from a separate API call

  String get country =>
      originalLanguage == 'en'
          ? 'USA'
          : originalLanguage == 'pt'
          ? 'Brasil'
          : originalLanguage == 'es'
          ? 'España'
          : originalLanguage == 'fr'
          ? 'France'
          : originalLanguage == 'zh'
          ? 'China'
          : 'N/A';

  String get formattedBudget =>
      budget != null && budget! > 0 ? 'U\$ ${budget!.toString()}' : 'N/A';

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      originalLanguage: json['original_language'],
      popularity:
          json['popularity'] != null
              ? (json['popularity'] as num).toDouble()
              : null,
      // These fields are only available in detailed movie responses
      status: json['status'],
      budget: json['budget'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      // Genres need special handling as they come as objects in detailed responses
      genres:
          json['genres'] != null
              ? (json['genres'] as List)
                  .map((genre) => genre['name'] as String)
                  .toList()
              : null,
    );
  }
}
