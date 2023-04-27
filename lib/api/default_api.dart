import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

// This is Get Api , default
// If api needs header , add header , if need to add param , add like apiKey
class GetApi {
  String _baseUrl = "https://spotify23.p.rapidapi.com/";
  final Map<String, String> _header = {};
  String _apiKey = "";
  String _apiHost = "";

  Future<Response> getApi(
      {required String endPoint,
      String? baseUrl,
      String? apiKey,
      String? apiHost}) async {
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }
    if (apiKey != null) {
      _apiKey = apiKey;
    }
    _header["X-RapidAPI-Key"] = _apiKey;
    if (apiHost != null) {
      _apiHost = apiHost;
    }
    _header["X-RapidAPI-Host"] = _apiHost;

    return await http.get(Uri.parse("$_baseUrl$endPoint"), headers: _header);
  }
}
