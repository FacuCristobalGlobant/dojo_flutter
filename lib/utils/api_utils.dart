import 'package:dojo_flutter/constants/constants.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Future<Map<String, dynamic>> callApi() async {
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
  var response = await http.get(
    url,
    headers: headers,
  );

  return jsonDecode(response.body);
}
