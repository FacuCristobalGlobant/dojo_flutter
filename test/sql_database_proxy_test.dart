import 'dart:math';

import 'package:dojo_flutter/feature/local_database/data/datasource/sqlite_database_data_source.dart';
import 'package:dojo_flutter/feature/local_database/data/datasource/sqlite_database_proxy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_data/movie_mock.dart';
@GenerateNiceMocks([MockSpec<SqlDatabaseDataSource>()])
import 'sql_database_proxy_test.mocks.dart';

void main() {
  test(
    'Get movies from database proxy test, empty result',
    () async {
      final mockedDatabaseDatasource = MockSqlDatabaseDataSource();
      final databaseProxy = SqlDatabaseProxy();
      databaseProxy.dataSource = mockedDatabaseDatasource;

      when(mockedDatabaseDatasource.getPopularMovies()).thenAnswer(
        (_) async => <String, dynamic>{},
      );
      final result = await databaseProxy.getPopularMovies();

      expect(result, <String, dynamic>{});
    },
  );
  test(
    'Get movies from database proxy test, 1 result',
    () async {
      final mockedDatabaseDatasource = MockSqlDatabaseDataSource();
      final databaseProxy = SqlDatabaseProxy();
      databaseProxy.dataSource = mockedDatabaseDatasource;

      when(mockedDatabaseDatasource.getPopularMovies()).thenAnswer(
        (_) async => MovieMock.mockedApiResponseMovie,
      );

      final result = await databaseProxy.getPopularMovies();

      expect(result, containsPair('title', 'title'));
    },
  );

  test(
    'Insert a movie',
    () async {
      final mockedDatabaseDatasource = MockSqlDatabaseDataSource();
      final databaseProxy = SqlDatabaseProxy();
      databaseProxy.dataSource = mockedDatabaseDatasource;

      when(mockedDatabaseDatasource.insertMovies([MovieMock.mockedMovie]))
          .thenAnswer(
        (_) async => 1,
      );

      await databaseProxy.insertMovies([MovieMock.mockedMovie]);
    },
  );
}
