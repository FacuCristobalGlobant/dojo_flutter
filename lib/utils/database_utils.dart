import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dojo_flutter/models/models.dart';

class DatabaseUtils {
  static final DatabaseUtils _singleton = DatabaseUtils._internal();

  factory DatabaseUtils() {
    return _singleton;
  }

  DatabaseUtils._internal();

  late final Database _db;

  Future<Map<String, dynamic>> loadJsonFromFile(String filename) async {
    try {
      final file = File(filename);
      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString);
      return jsonMap;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading or parsing JSON: $e');
      }
      return {};
    }
  }

  Future<void> insertMovies(List<Movie> movies) async {
    for (final movie in movies) {
      if (movie.genreIds != null) {
        for (final genre in movie.genreIds!) {
          await _db.insert(
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

      await _db.insert(
        'movies',
        processedMovie,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Movie>> getMovies() async {
    List<Movie> result = [];
    if (_db.isOpen) {
      final List<Map<String, Object?>> moviesMap = await _db.query('movies');

      for (final movieMap in moviesMap) {
        final List<Map<String, Object?>> genreMovieMap = await _db.rawQuery(
            'SELECT genreId FROM moviesGenre WHERE movieId = ${movieMap['id']}');
        final genres = genreMovieMap.map((rawGenre) => rawGenre['genreId']).map(
              (element) => int.parse(
                element.toString(),
              ),
            );

        result.add(
          Movie(
            adult: movieMap['adult'] != 0,
            backdropPath: movieMap['backdropPath'] as String?,
            genreIds: genres.toList(),
            id: movieMap['id'] as int?,
            originalLanguage: movieMap['original_language'] as String?,
            originalTitle: movieMap['original_title'] as String?,
            overview: movieMap['overview'] as String?,
            popularity: movieMap['popularity'] as double?,
            posterPath: movieMap['poster_path'] as String?,
            releaseDate: movieMap['release_date'] as String?,
            title: movieMap['title'] as String?,
            video: movieMap['video'] != 0,
            voteAverage: movieMap['vote_average'] as double?,
            voteCount: movieMap['vote_count'] as int?,
          ),
        );
      }
    }

    return result;
  }

  Future<void> createDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'movies.db'),
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
