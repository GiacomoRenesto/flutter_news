import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsItemWeb extends StatelessWidget{

  final Article article;
  final _key = UniqueKey();

  var url;

  NewsItemWeb(String newsUrl, {Key key, this.article}):super (key: key) {
    url = newsUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: article.url,
            ))
      ],
    );
  }

}

