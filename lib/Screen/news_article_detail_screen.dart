import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mvvm/ViewModel/news_article_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  final NewsArticleViewModel article;

  const NewsArticleDetailScreen({Key key, @required this.article})
      : super(key: key);

  _launchURL(String aUrl) async {
    var url = aUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 50),
          horizontalTitleGap: 40,
          leading: CircleAvatar(backgroundImage: AssetImage("profile.jpeg")),
          title: Text(
            this.article.author ?? 'Undefined',
          ),
          subtitle: Text("Author"),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    placeholder: (context, String value) =>
                        CircularProgressIndicator(),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  article.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  maxLines: 4,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    article.publishedAt ?? " ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  article.content.replaceRange(article.content.indexOf("["),
                          article.content.indexOf("]"), " ") ??
                      article.description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
                TextButton(
                  onPressed: () => _launchURL(article.url),
                  child: Text(
                    article.url,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.lightBlue),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
