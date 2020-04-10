import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article.dart';

class NewsItem extends StatelessWidget{

  final Article article;

  NewsItem(this.article, {Key key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Column(
        children: <Widget>[
          Card(
            child:Image.network(article.urlToImage),
          ),
          Text(article.title),
          Text(article.author),
          Text(article.publishedAt)
        ],
      ),
    );
  }

}