import 'package:flutternews/models/articlesHolder.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/screens/news.dart';
import 'package:flutternews/screens/news_web_detail.dart';
import 'package:flutternews/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return ChangeNotifierProvider(
      create: (context) => ArticlesHolder(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        initialRoute: '/',
        theme: appTheme,
        routes: {
          '/': (context) => News(),
          '/news_web_detail': (context) => NewsWebDetail(),
//          '/my_news': (context) => Search(),
        },
      ),
    );
  }
}
