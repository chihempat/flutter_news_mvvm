import 'package:flutter/material.dart';
import 'package:flutter_mvvm/Widget/news_grid.dart';
import 'package:flutter_mvvm/ViewModel/news_article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm/Extras/constants.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .topHeadlines();
  }

  void getNewsByCountry(
      NewsArticleListViewModel listViewModel, String country) {
    listViewModel.topHeadlinesByCountry(Constants.Countries[country]);
  }

  Widget _buildlist(NewsArticleListViewModel listViewModel) {
    var ls = listViewModel.loadingStatus;
    switch (ls) {
      case LoadingStatus.searching:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      case LoadingStatus.completed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: NewsGrid(articles: listViewModel.articles),
        );
        break;
      case LoadingStatus.empty:
        return Center(
          child: Text("No Results Found"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<NewsArticleListViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: (value) => getNewsByCountry(listViewModel, value),
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) {
              return Constants.Countries.keys
                  .map((value) => PopupMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Text(
                "News",
                style: TextStyle(fontSize: 50),
              ),
            ),
            Divider(
              height: 20,
              color: Colors.grey[700],
              thickness: 10,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 15, bottom: 15),
              child: Text(
                'Headlines',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: _buildlist(listViewModel),
            ),
          ],
        ),
      ),
    );
  }
}
