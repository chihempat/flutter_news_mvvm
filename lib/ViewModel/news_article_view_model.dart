import 'package:flutter_mvvm/Model/news_article.dart';
import 'package:intl/intl.dart';

class NewsArticleViewModel
{
  NewsArticle _newsArticle;

  NewsArticleViewModel({NewsArticle article}): _newsArticle = article;

  String get title => _newsArticle.title;
  String get description => _newsArticle.description;
  String get author => _newsArticle.author;
  String get imageUrl =>_newsArticle.urlToImage;
  String get url=> _newsArticle.url;
  String get content=>_newsArticle.content;
  String get publishedAt=>DateFormat.yMMMMEEEEd('en-us').format(DateFormat('dd-MM-yyyyTHH:mm:ssZ').parse(_newsArticle.publishedAt, true)).toString();

}