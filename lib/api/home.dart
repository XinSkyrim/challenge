import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_challenge/viewmodels/home.dart';

// Wrap URL with CORS proxy for web requests
String _wrapCorsProxy(String url) {
  return "https://corsproxy.io/?$url";
}

// Fetch trip category cards
Future<CategoryCardList> getTripsListAPI() async {
  final url =
      "https://pfx-interview.s3.ap-southeast-2.amazonaws.com/trips.json";
  final proxyUrl = _wrapCorsProxy(url);

  try {
    final response = await http
        .get(Uri.parse(proxyUrl))
        .timeout(
      const Duration(seconds: 15),
      onTimeout: () => throw Exception("Request timeout (15 seconds)"),
    );

    if (response.body.isEmpty) {
      throw Exception("Empty response body");
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CategoryCardList.formJSON(data);
    } else {
      throw Exception(
        "Request failed with status code: ${response.statusCode}",
      );
    }
  } catch (e) {
    rethrow;
  }
}

// Fetch living style category cards
Future<CategoryCardList> getLivingStyleListAPI() async {
  final url =
      "https://pfx-interview.s3.ap-southeast-2.amazonaws.com/living-style.json";
  final proxyUrl = _wrapCorsProxy(url);

  try {
    final response = await http
        .get(Uri.parse(proxyUrl))
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception("Request timeout"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CategoryCardList.formJSON(data);
    } else {
      throw Exception(
        "Request failed with status code: ${response.statusCode}",
      );
    }
  } catch (e) {
    rethrow;
  }
}

// Fetch other experiences category cards
Future<CategoryCardList> getOtherExperiencesListAPI() async {
  final url =
      "https://pfx-interview.s3.ap-southeast-2.amazonaws.com/other-experiences.json";
  final proxyUrl = _wrapCorsProxy(url);

  try {
    final response = await http
        .get(Uri.parse(proxyUrl))
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception("Request timeout"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CategoryCardList.formJSON(data);
    } else {
      throw Exception(
        "Request failed with status code: ${response.statusCode}",
      );
    }
  } catch (e) {
    rethrow;
  }
}
