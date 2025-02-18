import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie.dart';

part 'tmdb_response.freezed.dart';
part 'tmdb_response.g.dart';

@freezed
class TmdbResponse with _$TmdbResponse {
  const factory TmdbResponse({
    required int? page,
    required List<Movie>? results,
    required int? totalPages,
    required int? totalResults,
  }) = _TmbdResponse;

  factory TmdbResponse.fromJson(Map<String, Object?> json) => _$TmdbResponseFromJson(json);
}
