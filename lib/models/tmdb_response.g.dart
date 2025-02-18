// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TmbdResponseImpl _$$TmbdResponseImplFromJson(Map<String, dynamic> json) =>
    _$TmbdResponseImpl(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      totalResults: (json['total_results'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TmbdResponseImplToJson(_$TmbdResponseImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
