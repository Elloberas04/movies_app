import 'package:movies_app/models/models.dart';

class CreditsResponse {
  int id;
  List<Cast> cast;

  CreditsResponse({
    required this.id,
    required this.cast,
  });

  factory CreditsResponse.fromRawJson(String str) =>
      CreditsResponse.fromJson(json.decode(str));

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
      );
}
