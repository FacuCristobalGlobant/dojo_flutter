import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/core/interfaces/i_repository.dart';

abstract class IMoviesRepository extends IRepository{
  Future<List<Movie>> getPopularMovies();
}