import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CustomSearch extends SearchDelegate {
  final List<Movie> movies;
  final BuildContext _context;

  CustomSearch(this._context, this.movies);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(_context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMoviesBySearch("true", query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final matchQuery = snapshot.data!;

        return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'details',
                    arguments: matchQuery[index]);
              },
              child: ListTile(
                title: Text(matchQuery[index].title),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Movie> matchQuery = [];

    for (var movie in movies) {
      if (movie.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(movie);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'details',
                arguments: matchQuery[index]);
          },
          child: ListTile(
            title: Text(matchQuery[index].title),
          ),
        );
      },
    );
  }
}
