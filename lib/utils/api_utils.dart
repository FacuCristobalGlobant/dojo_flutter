import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/models/models.dart';
import 'package:dojo_flutter/utils/database_utils.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<List<Movie>> callApi() async {
  final dbUtils = DatabaseUtils();

  try {
    await dotenv.load(fileName: ".env");
    final String apiKey = dotenv.env['API_KEY']!;

    final baseUrl = ApiConstants.baseUrl;
    final unencodedPath = ApiConstants.unencodedPath;
    final queryParameters = {
      ApiConstants.language: [ApiConstants.enUs],
      ApiConstants.sortBy: [ApiConstants.sortPopularityDescending]
    };
    final Map<String, String> headers = {
      ApiConstants.authorizationHeader: 'Bearer $apiKey',
      ApiConstants.accept: ApiConstants.acceptApplicationJson,
    };

    var url = Uri.https(
      baseUrl,
      unencodedPath,
      queryParameters,
    );
    var response = await http
        .get(
      url,
      headers: headers,
    )
        .timeout(
      Duration(seconds: 3),
      onTimeout: () {
        throw Exception('request timeout');
      },
    );

    final tmdbResponse = TmdbResponse.fromJson(jsonDecode(response.body));

    if (tmdbResponse.results != null) {
      dbUtils.insertMovies(tmdbResponse.results!);
      return tmdbResponse.results!;
    } else {
      return [];
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }

    final result = await dbUtils.getMovies();

    return result;
  }
}
