import 'package:flutter/material.dart';
import 'package:flutter_mvvm/Screen/news_article_detail_screen.dart';
import 'package:flutter_mvvm/ViewModel/news_article_view_model.dart';
import 'package:flutter_mvvm/Widget/circular_image.dart';

class NewsGrid extends StatelessWidget {
  final List<NewsArticleViewModel> articles;
  NewsGrid({this.articles});

  void articleSelected(context, NewsArticleViewModel article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsArticleDetailScreen(
          article: article,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width < 700
              ? 2
              : MediaQuery.of(context).size.width < 1200
                  ? 3
                  : 4,
        ),
        itemBuilder: (context, index) {
          var article = articles[index];
          return GestureDetector(
            onTap: () => articleSelected(context, article),
            child: GridTile(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: CircularImage(imageUrl: article.imageUrl),
              ),
              footer: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  article.title,
                  style: TextStyle(fontWeight: FontWeight.normal),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
        itemCount: this.articles.length,
      ),
    );
  }
}
