// package we need for json encode/decode
import 'dart:convert';

import 'package:dio/dio.dart';
// service helper for loading json file
import 'package:flutter/services.dart' as rootBundle;
import 'package:project_struct/core/api_client.dart';

class MovieService {
  final ApiClient _dio = ApiClient();

  Future<List<dynamic>> fetchMovies([filter = ""]) async {
    // Load json data
    final moviesData = await _dio.get('/movies?Title=$filter');
    // Decode json data to list
    return moviesData;
  }

  Future<dynamic> fetchMovie(id) async {
    // Load json data
    final moviesData = await _dio.get('/movies/$id');
    // Decode json data to list
    return moviesData;
  }

  Future<dynamic> updateMovie(id, movieData) async {
    // Load json data
    try {
      final response = await _dio.put(
        '/movies/$id',
        params: movieData,
      );
      return response;
    } on DioError catch (err) {
      throw err;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> deleteMovie(id) async {
    // Load json data
    try {
      final response = await _dio.deleteWithBody('/movies/$id');
      return response.data;
    } on DioError catch (err) {
      throw err;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<dynamic>> fetchLocalMovies() async {
    await Future.delayed(const Duration(seconds: 1));
    // Load json data
    final moviesData =
        await rootBundle.rootBundle.loadString('data/movies.json');
    // Decode json data to list
    return json.decode(moviesData) as List<dynamic>;
  }
}
