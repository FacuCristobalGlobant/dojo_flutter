import 'package:flutter/foundation.dart';

import 'package:dojo_flutter/feature/local_database/data/datasource/database_data_source.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/tmdb_response.dart';
import 'package:dojo_flutter/feature/api_client/domain/repository/i_movies_repository.dart';
import 'package:dojo_flutter/feature/api_client/data/datasource/data_source.dart';

class ApiMovieRepository implements IMoviesRepository {
  ApiMovieRepository({
    required this.mainDataSource,
    required this.localDatabase,
  });

  final DataSource mainDataSource;
  final DatabaseDataSource localDatabase;

  @override
  Future<List<Movie>> getPopularMovies() async {
    final List<Movie> result = <Movie>[];
    try {
      final TmdbResponse tmdbResponse =
          TmdbResponse.fromJson(await mainDataSource.getPopularMovies());

      result.addAll(tmdbResponse.results);
      await localDatabase.insertMovies(tmdbResponse.results);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      final TmdbResponse tmdbResponse =
          TmdbResponse.fromJson(await localDatabase.getPopularMovies());

      result.addAll(tmdbResponse.results);
      await localDatabase.insertMovies(tmdbResponse.results);
    }

    return result;
  }
}
