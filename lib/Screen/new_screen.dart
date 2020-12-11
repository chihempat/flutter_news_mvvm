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
  String country = "India";
  String category = "general";

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

  void getNewsByCategory(
      NewsArticleListViewModel listViewModel, String category, String country) {
    country = country ?? "India";
    category = category ?? "General";
    listViewModel.topHeadlinesByCategory(
        category, Constants.Countries[country]);
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
    var width = MediaQuery.of(context).size.width;
    var w = MediaQuery.of(context).size.width / 1000;
    var h = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              getNewsByCountry(listViewModel, value);
              setState(() {
                country = value;
              });
              getNewsByCountry(listViewModel, value);
            },
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
        minimum: EdgeInsets.symmetric(horizontal: width < 1000 ? 0 : 100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Text(
                "News",
                style: TextStyle(fontSize: width < 1000 ? 60 : 100),
              ),
            ),
            Divider(
              height: 40,
              color: Colors.grey[700],
              thickness: 5,
              indent: 30,
              endIndent: 30,
            ),
            Center(
              child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  overflowDirection: VerticalDirection.down,
                  buttonAlignedDropdown: false,
                  children: Constants.Category.map(
                    (value) => TextButton(
                      onPressed: () {
                        setState(() {
                          category = value;
                        });
                        getNewsByCategory(listViewModel, value, country);
                      },
                      child: Text(
                        value.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: width < 650
                                ? 15
                                : width < 1000
                                    ? 15
                                    : 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ).toList()),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       right: 30, left: 30, top: 15, bottom: 15),
            //   child: Text(
            //     'Headlines',
            //     style: TextStyle(
            //       fontWeight: FontWeight.normal,
            //       fontSize: width < 1000 ? 30 : 50,
            //     ),
            //   ),
            // ),
            Expanded(
              child: _buildlist(listViewModel),
            ),
          ],
        ),
      ),
    );
  }
}
