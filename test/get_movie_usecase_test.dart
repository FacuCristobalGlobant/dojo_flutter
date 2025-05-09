import 'package:dojo_flutter/feature/api_client/data/repository/api_movie_repository.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/domain/usecase/get_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_data/movie_mock.dart';
@GenerateNiceMocks([MockSpec<ApiMovieRepository>()])
import 'get_movie_usecase_test.mocks.dart';

void main() {
  test(
    'Call movie use case',
    () async {
      final repository = MockApiMovieRepository();

      final getMoviesUseCase = GetMoviesUseCase(repository);

      when(repository.getPopularMovies()).thenAnswer((_) async => <Movie>[]);

      final result = await getMoviesUseCase.call();

      expect(
        result,
        isEmpty,
      );
    },
  );
}
