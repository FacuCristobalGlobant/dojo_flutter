// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tmdb_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TmdbResponse _$TmdbResponseFromJson(Map<String, dynamic> json) {
  return _TmbdResponse.fromJson(json);
}

/// @nodoc
mixin _$TmdbResponse {
  int? get page => throw _privateConstructorUsedError;
  List<Movie>? get results => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;
  int? get totalResults => throw _privateConstructorUsedError;

  /// Serializes this TmdbResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TmdbResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TmdbResponseCopyWith<TmdbResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TmdbResponseCopyWith<$Res> {
  factory $TmdbResponseCopyWith(
          TmdbResponse value, $Res Function(TmdbResponse) then) =
      _$TmdbResponseCopyWithImpl<$Res, TmdbResponse>;
  @useResult
  $Res call(
      {int? page, List<Movie>? results, int? totalPages, int? totalResults});
}

/// @nodoc
class _$TmdbResponseCopyWithImpl<$Res, $Val extends TmdbResponse>
    implements $TmdbResponseCopyWith<$Res> {
  _$TmdbResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TmdbResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? results = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TmbdResponseImplCopyWith<$Res>
    implements $TmdbResponseCopyWith<$Res> {
  factory _$$TmbdResponseImplCopyWith(
          _$TmbdResponseImpl value, $Res Function(_$TmbdResponseImpl) then) =
      __$$TmbdResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page, List<Movie>? results, int? totalPages, int? totalResults});
}

/// @nodoc
class __$$TmbdResponseImplCopyWithImpl<$Res>
    extends _$TmdbResponseCopyWithImpl<$Res, _$TmbdResponseImpl>
    implements _$$TmbdResponseImplCopyWith<$Res> {
  __$$TmbdResponseImplCopyWithImpl(
      _$TmbdResponseImpl _value, $Res Function(_$TmbdResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TmdbResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? results = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
  }) {
    return _then(_$TmbdResponseImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Movie>?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TmbdResponseImpl implements _TmbdResponse {
  const _$TmbdResponseImpl(
      {required this.page,
      required final List<Movie>? results,
      required this.totalPages,
      required this.totalResults})
      : _results = results;

  factory _$TmbdResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TmbdResponseImplFromJson(json);

  @override
  final int? page;
  final List<Movie>? _results;
  @override
  List<Movie>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totalPages;
  @override
  final int? totalResults;

  @override
  String toString() {
    return 'TmdbResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TmbdResponseImpl &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page,
      const DeepCollectionEquality().hash(_results), totalPages, totalResults);

  /// Create a copy of TmdbResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TmbdResponseImplCopyWith<_$TmbdResponseImpl> get copyWith =>
      __$$TmbdResponseImplCopyWithImpl<_$TmbdResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TmbdResponseImplToJson(
      this,
    );
  }
}

abstract class _TmbdResponse implements TmdbResponse {
  const factory _TmbdResponse(
      {required final int? page,
      required final List<Movie>? results,
      required final int? totalPages,
      required final int? totalResults}) = _$TmbdResponseImpl;

  factory _TmbdResponse.fromJson(Map<String, dynamic> json) =
      _$TmbdResponseImpl.fromJson;

  @override
  int? get page;
  @override
  List<Movie>? get results;
  @override
  int? get totalPages;
  @override
  int? get totalResults;

  /// Create a copy of TmdbResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TmbdResponseImplCopyWith<_$TmbdResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
