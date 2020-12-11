import 'package:flutter/material.dart';
import 'package:flutter_mvvm/Screen/new_screen.dart';
import 'package:flutter_mvvm/ViewModel/news_article_list_view_model.dart';
import 'package:provider/provider.dart';

String api = "28fd11a721614f89bac1f4557a3854ad";
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: ThemeData(
        fontFamily: "GlacialIndifference",
        scaffoldBackgroundColor: Color(0xffFEFDFD),
        appBarTheme: AppBarTheme(
          color: Color(0xffFEFDFD),
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => NewsArticleListViewModel())
      ], child: NewScreen()),
    );
  }
}
