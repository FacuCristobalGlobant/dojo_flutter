import 'package:dojo_flutter/constants/measures.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/presentation/widget/movie_card.dart';
import 'package:dojo_flutter/feature/api_client/presentation/widget/sort_button.dart';
import 'package:flutter/material.dart';

List<Widget> buildMoviesList(List<Movie> movies) {
  final List<Widget> movieWidgets = [];

  movieWidgets.sort();

  movieWidgets.addAll(movies.map<Widget>(
    (movie) => MovieCard(movie: movie),
  ));
  return movieWidgets;
}

int sortMoviesByName(Movie a, Movie b) {
  return a.title!.compareTo(b.title!);
}

int sortMoviesByVoteAverage(Movie a, Movie b) {
  return a.voteAverage!.compareTo(b.voteAverage!);
}

int sortMoviesByPopularity(Movie a, Movie b) {
  return a.popularity!.compareTo(b.popularity!);
}

class HorizontalMovieList extends StatefulWidget {
  const HorizontalMovieList({
    super.key,
    required this.movieList,
  });

  final List<Movie> movieList;

  @override
  State<HorizontalMovieList> createState() => _HorizontalMovieListState();
}

class _HorizontalMovieListState extends State<HorizontalMovieList> {
  late final List<Movie> movieList;
  late int Function(Movie, Movie) sortMethod;

  @override
  void initState() {
    sortMethod = sortMoviesByName;
    movieList = widget.movieList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    movieList.sort(sortMethod);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Column(
            children: [
              SizedBox(
                height: Measures.small,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Measures.large,
                  vertical: Measures.small,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sort By',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 2.0,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Measures.xSmall,
                  bottom: Measures.small,
                  left: Measures.medium,
                ),
                child: OverflowBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    SortButton(
                      onPressed: () {
                        sortMethod = sortMoviesByName;
                        setState(() {});
                      },
                      isSelected: sortMethod == sortMoviesByName,
                      displayText: 'Title',
                    ),
                    SortButton(
                      onPressed: () {
                        sortMethod = sortMoviesByPopularity;
                        setState(() {});
                      },
                      isSelected: sortMethod == sortMoviesByPopularity,
                      displayText: 'Popularity',
                    ),
                    SortButton(
                      onPressed: () {
                        sortMethod = sortMoviesByVoteAverage;
                        setState(() {});
                      },
                      isSelected: sortMethod == sortMoviesByVoteAverage,
                      displayText: 'Vote Average',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Measures.cardHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: buildMoviesList(widget.movieList),
          ),
        ),
      ],
    );
  }
}
