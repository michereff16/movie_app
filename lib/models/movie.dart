class Movie {
  final String id;
  final String title;
  final String? originalTitle;
  final String posterUrl;
  final double rating;
  final int votes;
  final String? releaseDate;
  final String? country;
  final String? budget;
  final List<String>? genres;
  final String? summary;
  final String? ageRating;
  final String? year;

  Movie({
    required this.id,
    required this.title,
    this.originalTitle,
    required this.posterUrl,
    required this.rating,
    required this.votes,
    this.releaseDate,
    this.country,
    this.budget,
    this.genres,
    this.summary,
    this.ageRating,
    this.year,
  });
}
