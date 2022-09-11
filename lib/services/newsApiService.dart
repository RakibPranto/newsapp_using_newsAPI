import 'dart:convert';

import 'package:newsapp/models/model.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  static Future<List<Articles>> fetchNewsData(
      {required int page, required String sortBy}) async {
    List<Articles> newsList = [];

    try {
      var link =
          "https://newsapi.org/v2/everything?q=bangladesh&apiKey=dee7ee20e389469bb7066a81e61ce95b&page=$page&sortBy=$sortBy";
      var response = await http.get(Uri.parse(link));
      var data = jsonDecode(response.body);
      Articles articles;
      for (var i in data['articles']) {
        articles = Articles.fromJson(i);
        newsList.add(articles);
      }
    } catch (e) {
      print("the problem is $e");
    }
    return newsList;
  }

  static Future<List<Articles>> fetchSearchData({required String query}) async {
    List<Articles> searchList = [];

    try {
      var link =
          "https://newsapi.org/v2/everything?q=$query&apiKey=dee7ee20e389469bb7066a81e61ce95b";
      var response = await http.get(Uri.parse(link));
      print(response.body);
      var data = jsonDecode(response.body);
      Articles articles;
      for (var i in data['articles']) {
        articles = Articles.fromJson(i);
        searchList.add(articles);
      }
    } catch (e) {
      print("the problem is $e");
    }
    return searchList;
  }
}
