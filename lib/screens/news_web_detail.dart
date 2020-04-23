
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article.dart';
import 'package:flutternews/models/articlesHolder.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebDetail extends StatefulWidget {
  NewsWebDetail();

  @override
  NewsWebDetailState createState() => NewsWebDetailState();
}

class NewsWebDetailState extends State<NewsWebDetail> {
  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  final key = UniqueKey();
  bool isAddedToFav = false;

  @override
  Widget build(BuildContext context) {
    Article article = Provider.of<ArticlesHolder>(context, listen: false).selectedArticle;

    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueGrey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:  Image.asset("assets/logo_app.png",
            height: 100,
            width: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                  key: key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: article.url,
                ))
          ],
        ),
        );
  }

}