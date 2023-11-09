import 'package:movies_app/models/models.dart';

class TopRatedResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  TopRatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TopRatedResponse.fromRawJson(String str) =>
      TopRatedResponse.fromJson(json.decode(str));

  factory TopRatedResponse.fromJson(Map<String, dynamic> json) =>
      TopRatedResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
