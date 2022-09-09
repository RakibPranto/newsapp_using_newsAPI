import 'dart:convert';

import 'package:newsapp/models/model.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  static Future<List<Articles>> fetchNewsData(
      {required int page, required String sortBy}) async {
    List<Articles> newsList = [];

    try {
      var link =
          "https://newsapi.org/v2/everything?q=bangladesh&apiKey=a99a30ca38f3493e8583f729baab253d&page=$page&sortBy=$sortBy";
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
}
