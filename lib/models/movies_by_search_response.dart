import 'package:movies_app/models/models.dart';

class MoviesBySearchResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MoviesBySearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesBySearchResponse.fromRawJson(String str) =>
      MoviesBySearchResponse.fromJson(json.decode(str));

  factory MoviesBySearchResponse.fromJson(Map<String, dynamic> json) =>
      MoviesBySearchResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
