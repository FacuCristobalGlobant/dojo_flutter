import 'package:dojo_flutter/feature/local_database/data/datasource/sqlite_database_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'mock_data/movie_mock.dart';
@GenerateNiceMocks([MockSpec<Database>()])
import 'sql_database_datasource_test.mocks.dart';

void main() {
  test(
    'Get movies from database test, empty result',
    () async {
      final mockDatabase = MockDatabase();

      final dataBaseDataSource = SqlDatabaseDataSource(db: mockDatabase);

      final popularMoviesResponse = await dataBaseDataSource.getPopularMovies();

      final movieList = popularMoviesResponse['results'];

      expect(movieList, isEmpty);
    },
  );
  test(
    'Get movies from database test, mocked movie result',
    () async {
      final mockDatabase = MockDatabase();

      when(mockDatabase.isOpen).thenAnswer((_) => true);

      when(mockDatabase.query('movies', orderBy: 'popularity desc'))
          .thenAnswer((_) async => <Map<String, dynamic>>[
                MovieMock.mockedMovie.toJson(),
              ]);

      when(mockDatabase.rawQuery(
              'SELECT genreId FROM moviesGenre WHERE movieId = 1 LIMIT 20'))
          .thenAnswer((_) async => <Map<String, dynamic>>[
                MovieMock.mockedGenre,
              ]);

      final dataBaseDataSource = SqlDatabaseDataSource(db: mockDatabase);

      final popularMoviesResponse = await dataBaseDataSource.getPopularMovies();

      final movieList = popularMoviesResponse['results'];

      expect(movieList, hasLength(1));
    },
  );
  test(
    'Insert Movies into db',
    () async {
      final mockDatabase = MockDatabase();

      final dataBaseDataSource = SqlDatabaseDataSource(db: mockDatabase);

      when(
        mockDatabase.insert(
          'moviesGenre',
          {
            'movieId': 1,
            'genreId': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        ),
      ).thenAnswer(
        (_) async => 1,
      );

      when(
        mockDatabase.insert(
          'movies',
          MovieMock.mockedMovie.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).thenAnswer(
        (_) async => 1,
      );

      final insertMovie =
          await dataBaseDataSource.insertMovies([MovieMock.mockedMovie]);
    },
  );
  test(
    'create database connection',
    () async {
      final mockDatabase = MockDatabase();

      final dataBaseDataSource = SqlDatabaseDataSource(
        db: mockDatabase,
      );

      when(
        mockDatabase.insert(
          'moviesGenre',
          {
            'movieId': 1,
            'genreId': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        ),
      ).thenAnswer(
        (_) async => 1,
      );

      when(
        mockDatabase.insert(
          'movies',
          MovieMock.mockedMovie.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).thenAnswer(
        (_) async => 1,
      );

      final insertMovie =
          await dataBaseDataSource.insertMovies([MovieMock.mockedMovie]);
    },
  );
}
