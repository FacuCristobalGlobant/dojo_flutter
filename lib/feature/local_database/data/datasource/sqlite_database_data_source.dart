import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_data_source.dart';

class SqlDatabaseDataSource implements DatabaseDataSource {

  static const _numberOfResults = 20;

  late final Database db;

  SqlDatabaseDataSource({Database? db}) {
    if (db != null) {
      this.db = db;
    } else {
      _createDatabaseConnection();
    }
  }

  @override
  Future<void> insertMovies(List<Movie> movies) async {
    for (final movie in movies) {
      if (movie.genreIds != null) {
        for (final genre in movie.genreIds!) {
          await db.insert(
            'moviesGenre',
            {
              'movieId': movie.id,
              'genreId': genre,
            },
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
      }

      final processedMovie = movie.toJson();
      processedMovie['adult'] = (processedMovie['adult']) ? 1 : 0;
      processedMovie['video'] = (processedMovie['video']) ? 1 : 0;
      processedMovie.remove('genre_ids');

      await db.insert(
        'movies',
        processedMovie,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getPopularMovies() async {
    List<Map<String, dynamic>> result = [];
    if (db.isOpen) {
      final List<Map<String, Object?>> moviesMap = await db.query(
          'movies', orderBy: 'popularity desc');

      for (final movieMap in moviesMap) {
        final List<Map<String, Object?>> genreMovieMap = await db.rawQuery(
            'SELECT genreId FROM moviesGenre WHERE movieId = ${movieMap['id']} LIMIT $_numberOfResults');
        final genres = genreMovieMap.map((rawGenre) => rawGenre['genreId']).map(
              (element) =>
              int.parse(
                element.toString(),
              ),
        );

        result.add(
          {
            'adult': movieMap['adult'] as bool?,
            'backdrop_path': movieMap['backdrop_path'] as String?,
            'genre_ids': genres.toList(),
            'id': movieMap['id'] as int?,
            'original_language': movieMap['original_language'] as String?,
            'original_title': movieMap['original_title'] as String?,
            'overview': movieMap['overview'] as String?,
            'popularity': movieMap['popularity'] as double?,
            'poster_path': movieMap['poster_path'] as String?,
            'release_date': movieMap['release_date'] as String?,
            'title': movieMap['title'] as String?,
            'video': movieMap['video'] != 0,
            'vote_average': movieMap['vote_average'] as double?,
            'vote_count': movieMap['vote_count'] as int?,
          },
        );
      }
    }

    final Map<String, dynamic> response = {
      'page': 1,
      'results': result,
      'totalPages': 1,
      'totalResults': _numberOfResults,
    };

    return response;
  }

  Future<void> _createDatabaseConnection({String name = 'movies.db'}) async {
    db = await openDatabase(
      join(await getDatabasesPath(), name),
      onCreate: (db, version) {
        db.execute('CREATE TABLE movies('
            'id INTEGER PRIMARY KEY, '
            'adult INTEGER, '
            'backdrop_path TEXT, '
            'original_language TEXT, '
            'original_title TEXT, '
            'overview TEXT, '
            'popularity FLOAT, '
            'poster_path TEXT, '
            'release_date TEXT, '
            'title TEXT, '
            'video INTEGER, '
            'vote_average FLOAT, '
            'vote_count INTEGER'
            ')');
        db.execute(
          'CREATE TABLE moviesGenre('
              'movieId INTEGER, '
              'genreId INTEGER, '
              'PRIMARY KEY (movieId, genreId)'
              ')',
        );
      },
      version: 1,
    );
  }
}
