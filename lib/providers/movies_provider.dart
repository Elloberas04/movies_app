import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseURL = 'api.themoviedb.org';
  final String _apiKey = 'a51d3c6df5b96a7d9c23531276356a04';
  final String _language = 'es-ES';
  final String _page = '1';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> moviesBySearch = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print("Movies Provider inicialitzat!");
    this.getOnDisplayMovies();
    this.getOnPopularsMovies();
    this.getOnTopRatedMovies();
    this.getOnUpcomingMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(
      _baseURL,
      '3/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromRawJson(result.body);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnPopularsMovies() async {
    print('getOnPopularsMovies');
    var url = Uri.https(
      _baseURL,
      '3/movie/popular',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final popularResponse = PopularResponse.fromRawJson(result.body);

    popularMovies = popularResponse.results;

    notifyListeners();
  }

  getOnTopRatedMovies() async {
    print('getOnTopRatedMovies');
    var url = Uri.https(
      _baseURL,
      '3/movie/top_rated',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final topRatedResponse = TopRatedResponse.fromRawJson(result.body);

    topRatedMovies = topRatedResponse.results;

    notifyListeners();
  }

  getOnUpcomingMovies() async {
    print('getOnUpcomingMovies');
    var url = Uri.https(
      _baseURL,
      '3/movie/upcoming',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final upcomingResponse = UpcomingResponse.fromRawJson(result.body);

    upcomingMovies = upcomingResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print('Demanam info al servidor');
    var url = Uri.https(
      _baseURL,
      '3/movie/$idMovie/credits',
      {
        'api_key': _apiKey,
        'language': _language,
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromRawJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> getMoviesBySearch(String adult, String query) async {
    print('Cercant pelis al servidor...');
    var url = Uri.https(
      _baseURL,
      '3/search/movie',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': _page,
        'query': query,
        'include_adult': adult
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final moviesBySearchResponse =
        MoviesBySearchResponse.fromRawJson(result.body);

    return moviesBySearchResponse.results;
  }
}
