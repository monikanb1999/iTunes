import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/Model/iTunesSearchModel.dart';

class iTunesSearchViewModel {
  Future collectionNameData({int? collectionName}) async {
    final Dio dio = Dio();
    Map<String, dynamic> data = {};

    final response = await dio.post(
      'https://itunes.apple.com/search?term=${collectionName}',
    );
    try {
      if (response.statusCode == 200) {
        print("Success");

        // Ensure response.data is not null and is a String
        if (response.data != null) {
          data = jsonDecode(response.data);

          return data;
        } else {
          throw Exception("Response data is null or not a String");
        }
      } else if (response.statusCode == 404) {
        print('Resource not found');
        return null;
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return data; // Handle errors by returning null or a default value
  }

  Future fetchLISTGRIDData({String? author, List<String>? kind}) async {
    final Dio dio = Dio();
    Map<String, dynamic> data = {};
    print(kind);
    final entities = kind?.join(',');
    final response = await dio.post(
      'https://itunes.apple.com/search?term=${author}&entity=${entities}',
    );
    try {
      if (response.statusCode == 200) {
        print("Success");

        // Ensure response.data is not null and is a String
        if (response.data != null) {
          data = jsonDecode(response.data);

          return data;
        } else {
          throw Exception("Response data is null or not a String");
        }
      } else if (response.statusCode == 404) {
        print('Resource not found');
        return null;
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return data; // Handle errors by returning null or a default value
  }
}
