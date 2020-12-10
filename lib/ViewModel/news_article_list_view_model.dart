import 'package:flutter/material.dart';
import 'package:flutter_mvvm/Model/news_article.dart';
import 'package:flutter_mvvm/ViewModel/news_article_view_model.dart';
import 'package:flutter_mvvm/Services/web_service.dart';

enum LoadingStatus { completed, searching, empty }

class NewsArticleListViewModel extends ChangeNotifier {
  List<NewsArticleViewModel> articles = List<NewsArticleViewModel>();
  LoadingStatus loadingStatus = LoadingStatus.searching;

  void topHeadlines() async {
    List<NewsArticle> newsArticle = await WebService().fetchTopHeadlines();

    this.articles = newsArticle
        .map((article) => NewsArticleViewModel(article: article))
        .toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void topHeadlinesByCountry(String country) async {
    List<NewsArticle> newsArticle =
        await WebService().fetchCountriesHeadlines(country);

    this.articles = newsArticle
        .map((article) => NewsArticleViewModel(article: article))
        .toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}
