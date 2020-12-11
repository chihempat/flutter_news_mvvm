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
        title: Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage("profile.jpeg")),
            title: Text(
              this.article.author ?? 'Anon',
            ),
            subtitle: Text("Author"),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Divider(
                      height: 80,
                      color: Colors.grey,
                      thickness: 20,
                    ),
                    Text(
                      ' Headline',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  this.article.title,
                  style: TextStyle(
                    fontSize: 24,
                    wordSpacing: 3,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  this.article.publishedAt,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  article.content ?? article.description,
                  style: TextStyle(fontSize: 17),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
                TextButton(
                  onPressed: () => _launchURL(article.url),
                  child: Text(
                    article.url,
                    style: TextStyle(
                        fontSize: 17,
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

// article.content.replaceRange(article.content.indexOf("["),
// article.content.indexOf("]"), " ") ??
// article.description,

// article.content.substring(
// 0, (article.content.indexOf("char")) - 9 ?? 50)
