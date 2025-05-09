import 'package:dojo_flutter/feature/api_client/data/datasource/data_source.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';

abstract class DatabaseDataSource extends DataSource {

  Future<void> insertMovies(List<Movie> movies);
}