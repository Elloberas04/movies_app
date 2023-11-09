import 'package:movies_app/models/models.dart';

class UpcomingResponse {
  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  UpcomingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingResponse.fromRawJson(String str) =>
      UpcomingResponse.fromJson(json.decode(str));

  factory UpcomingResponse.fromJson(Map<String, dynamic> json) =>
      UpcomingResponse(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
