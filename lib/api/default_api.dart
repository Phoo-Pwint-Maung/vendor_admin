import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:vendor_admin/custom_config/util/mainUrl.dart';

// This is Get Api , default
class GetApi {
  final dio = Dio();
  String _baseUrl = mainUrl;

  Future<Response> getApi({
    required String endPoint,
    String? baseUrl,
  }) async {
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }

    return await dio.get("$_baseUrl$endPoint");
  }
}

// Post Api
class PostApi {
  final dio = Dio();
  String url = "";

  Future<String> submitData({
    required String endPoint,
    int? id,
  }) async {
    if (id != null) {
      url = "$mainUrl$endPoint?$id";
    }
    url = "$mainUrl$endPoint";

    return url;

    // final response = await http.post(uri,
    //     body: jsonEncode(body), headers: {"Content-Type": "application/json"});
  }
}

// Delete Api
class DeleteApi {
  final dio = Dio();
  String _baseUrl = "https://api.nstack.in/v1/todos/";

  Future<Response> deleteApi({
    required String id,
    String? baseUrl,
  }) async {
    if (baseUrl != null) {
      _baseUrl = baseUrl;
    }

    return await dio.delete("$_baseUrl$id");
  }
}

// Put Api
class PutApi {
  final dio = Dio();

  Future<void> submitData(TextEditingController title,
      TextEditingController description, String id) async {
    final titleText = title.text;
    final desText = description.text;

    final body = {
      "title": titleText,
      "description": desText,
      "is_completed": false
    };

    String url = "https://api.nstack.in/v1/todos/$id";

    final response = await dio.put(
      url,
      data: body,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    if (response.statusCode == 200) {
      print("good put");
    } else {
      print('error');
    }

    // final response = await http.post(uri,
    //     body: jsonEncode(body), headers: {"Content-Type": "application/json"});
  }
}
