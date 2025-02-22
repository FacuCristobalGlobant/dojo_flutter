import 'package:dojo_flutter/utils/api_utils.dart';
import 'package:dojo_flutter/utils/database_utils.dart';
import 'package:flutter/material.dart';

import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/models/models.dart';
import 'package:dojo_flutter/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final dbUtils = DatabaseUtils();
    dbUtils.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Measures.large,
            ),
            Image.asset(
              AssetConstants.logoImage,
              height: Measures.xLarge,
            ),
            SizedBox(
              height: Measures.large,
            ),
            Container(
              color: Colors.white,
              height: Measures.xSmall,
              width: double.infinity,
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: callApi(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Movie>> snapshot,
        ) {
          if (snapshot.hasData) {
            final response = snapshot.data;

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
                      widget.title,
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
                      children: buildMoviesList(response!),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
