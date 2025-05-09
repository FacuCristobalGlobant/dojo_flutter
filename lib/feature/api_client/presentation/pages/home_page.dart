import 'package:dojo_flutter/constants/routes.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/presentation/controller/movie_bloc.dart';
import 'package:dojo_flutter/feature/api_client/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';

import 'package:dojo_flutter/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MovieBloc movieBloc;

  @override
  void initState() {
    movieBloc = context.read<MovieBloc>();
    movieBloc.add(GetPopularMoviesCalled());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Measures.large),
            child: ElevatedButton(
              onPressed: () {
                context.go(Routes.gallery);
              },
              child: Icon(
                Icons.photo,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Measures.large),
            child: OutlinedButton(
              onPressed: () {
                context.go(Routes.logout);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: Measures.xSmall, color: Colors.white),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, Measures.xSmall),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Measures.large),
            child: Container(
              color: Colors.white,
              height: Measures.xSmall,
              width: double.infinity,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Measures.medium),
              child: Image.asset(
                AssetConstants.logoImage,
                height: 32,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder<MovieBloc, MovieState>(
          bloc: movieBloc,
          builder: (context, state) {
            if (state is ErrorMovieState) {
              return Center(
                child: Text('Error loading data'),
              );
            } else if (state is LoadingMovieState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EmptyMovieState) {
              return Center(
                child: Text('No movies were found'),
              );
            } else if (state is InitialMovieState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OkMovieState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        Measures.large,
                      ),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Measures.xLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Measures.cardHeight,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: buildMoviesList(state.movies!),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Unknown error'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(Routes.camera);
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

List<Widget> buildMoviesList(List<Movie> movies) {
  final List<Widget> movieWidgets = [];

  movieWidgets.addAll(movies.map<Widget>(
    (movie) => MovieCard(movie: movie),
  ));
  return movieWidgets;
}
