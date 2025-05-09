import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/local_database/data/datasource/sqlite_database_data_source.dart';

import 'database_data_source.dart';

class SqlDatabaseProxy implements DatabaseDataSource {
  SqlDatabaseDataSource? _dataSource;
  final cashedMovies = <String, dynamic>{};

  set dataSource(SqlDatabaseDataSource value) {
    _dataSource = value;
  }

  Future<void> instatiateDatabase() async {
    _dataSource ??= SqlDatabaseDataSource();
  }

  @override
  Future<Map<String, dynamic>> getPopularMovies() async {
    instatiateDatabase();
    if (cashedMovies.isEmpty) {
      cashedMovies.clear();
      cashedMovies.addAll(await _dataSource!.getPopularMovies());
    }

    return cashedMovies;
  }

  @override
  Future<void> insertMovies(List<Movie> movies) async {
    instatiateDatabase();
    _dataSource!.insertMovies(movies);
  }
}
