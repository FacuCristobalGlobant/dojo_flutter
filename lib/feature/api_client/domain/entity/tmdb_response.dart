import 'package:dojo_flutter/feature/api_client/domain/entity/movie.dart';

class TmdbResponse {
  TmdbResponse({
    num? page,
    List<Movie>? results,
    num? totalPages,
    num? totalResults,
  }) {
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  TmdbResponse.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Movie.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  num? _page;
  List<Movie>? _results;
  num? _totalPages;
  num? _totalResults;
  TmdbResponse copyWith({
    num? page,
    List<Movie>? results,
    num? totalPages,
    num? totalResults,
  }) =>
      TmdbResponse(
        page: page ?? _page,
        results: results ?? _results,
        totalPages: totalPages ?? _totalPages,
        totalResults: totalResults ?? _totalResults,
      );
  num? get page => _page;
  List<Movie> get results => _results ?? <Movie>[];
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }
}
