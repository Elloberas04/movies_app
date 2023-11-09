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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(movies: moviesProvider.onDisplayMovie),
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
              MovieSlider(movies: moviesProvider.popularMovies),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}
