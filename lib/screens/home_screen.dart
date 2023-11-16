import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    // print(moviesProvider.onDisplayMovie);
    // print(moviesProvider.popularMovies);
    // print(moviesProvider.topRatedMovies);
    // print(moviesProvider.upcomingMovies);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(context, moviesProvider.onDisplayMovie),
              );
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovie),

              // Slider de pel·licules
              MovieSlider(
                  nom: 'Populars', movies: moviesProvider.popularMovies),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              const SizedBox(height: 20),
              MovieSlider(
                  nom: 'Top Rated', movies: moviesProvider.topRatedMovies),
              const SizedBox(height: 20),
              MovieSlider(
                  nom: 'Upcoming', movies: moviesProvider.upcomingMovies),
            ],
          ),
        ),
      ),
    );
  }
}
