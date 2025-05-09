import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';
import 'package:dojo_flutter/feature/api_client/domain/entity/tmdb_response.dart';

class MovieMock {
  static Movie mockedMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  static const Map<String, dynamic> mockedApiResponseMovie = {
    'adult': 0,
    'backdropPath': 'backdropPath',
    'genreIds': [1],
    'id': 1,
    'originalLanguage': 'originalLanguage',
    'originalTitle': 'originalTitle',
    'overview': 'overview',
    'popularity': 1.0,
    'posterPath': 'posterPath',
    'releaseDate': 'releaseDate',
    'title': 'title',
    'video': false,
    'voteAverage': 1.0,
    'voteCount': 1,
  };

  static const mockedGenre = {
    'genreId': 1,
  };

  static TmdbResponse tmdbResponse = TmdbResponse(
    page: 1,
    results: [mockedMovie],
    totalPages: 1,
    totalResults: 1,
  );
}
