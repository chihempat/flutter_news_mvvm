import 'package:dio/dio.dart';
import 'package:flutter_mvvm/Extras/constants.dart';
import 'package:flutter_mvvm/Model/news_article.dart';

class WebService {
  var dio = new Dio();

  Future<List<NewsArticle>> fetchTopHeadlines() async {
    String url = Constants.headlines_url;
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception("Failed to get top news");
    }
  }

  Future<List<NewsArticle>> fetchCountriesHeadlines(String country) async {
    String url = Constants.countryUrl(country);
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception("Failed to get top news");
    }
  }
}
