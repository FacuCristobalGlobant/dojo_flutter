import 'package:dojo_flutter/feature/api_client/data/datasource/api_data_source.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/data/repository/api_movie_repository.dart';
import 'package:dojo_flutter/feature/local_database/data/datasource/sqlite_database_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SqlDatabaseDataSource>()])
@GenerateNiceMocks([MockSpec<ApiDataSource>()])
import 'api_movie_repository_test.mocks.dart';

void main() {
  test(
    'Get movies from api test, empty result',
        () async {
      final mockSqlDatabaseDataSource = MockSqlDatabaseDataSource();
      final mockApiDataSource = MockApiDataSource();

      final movieRepository = ApiMovieRepository(
        mainDataSource: mockApiDataSource,
        localDatabase: mockSqlDatabaseDataSource,
      );

      when(mockApiDataSource.getPopularMovies())
          .thenAnswer((_) async => <String, dynamic>{});

      expect(await movieRepository.getPopularMovies(), <Movie>{});
    },
  );
}
