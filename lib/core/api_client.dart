import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'unauthorized_exception.dart';

class ApiClient {
  late final Dio _client = Dio(
    BaseOptions(
      baseUrl: 'https://62d29214afb0b03fc5a80930.mockapi.io',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final response = await _client.get(
      path,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.post(
      path,
      data: jsonEncode(params),
      
    );

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.delete(
      path,
      data: jsonEncode(params),
      
    );

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.statusCode);
    }
  }

  
  dynamic put(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.put(
      path,
      data: jsonEncode(params),
      
    );

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    return Uri.parse(
        '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString');
  }
}
