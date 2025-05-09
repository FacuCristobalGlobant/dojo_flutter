import 'package:dojo_flutter/core/interfaces/i_usecase.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/domain/repository/i_movies_repository.dart';

class GetMoviesUseCase implements IUseCase<List<Movie>>{

  final IMoviesRepository repository;

  GetMoviesUseCase(this.repository);

  @override
  Future<List<Movie>> call({Map<String, dynamic>? args}) async {
    return repository.getPopularMovies();
  }

}