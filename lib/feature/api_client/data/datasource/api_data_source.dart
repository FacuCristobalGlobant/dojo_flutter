import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/feature/api_client/data/datasource/data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class ApiDataSource implements DataSource {
  @override
  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      await dotenv.load(fileName: ".env");
      final String apiKey = dotenv.env['API_KEY']!;

      final queryParameters = {
        ApiConstants.language: [ApiConstants.enUs],
        ApiConstants.sortBy: [ApiConstants.sortPopularityDescending]
      };
      final Map<String, String> headers = {
        ApiConstants.authorizationHeader: 'Bearer $apiKey',
      };

      var url = Uri.https(
        ApiConstants.baseUrl,
        ApiConstants.unencodedPath,
        queryParameters,
      );
      var response = await http
          .get(
        url,
        headers: headers,
      )
          .timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw Exception('request timeout');
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      throw Exception('Unable to connect to TMDB API');
    }
  }
}
