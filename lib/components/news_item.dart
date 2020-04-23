import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article.dart';
import 'package:flutternews/models/articlesHolder.dart';
import 'package:provider/provider.dart';

class NewsItem extends StatelessWidget{

  final Article article;

  NewsItem(this.article, {Key key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<ArticlesHolder>(context, listen: false).setSelectedArticle = article;
          Navigator.pushNamed(context, '/news_web_detail');
        },
        child: Card(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Card(
                  child: ClipRRect(
                    child:Image.network(
                      article.urlToImage != null ? article.urlToImage : "https://via.placeholder.com/250",
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  )
              ),
              Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
//                                  leading: Text(news.articles[position].source + " " + news.articles[position].publishedAt),
                    title: Text(article.title,
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)
                    ),
                    subtitle: Text(article.source != null ? article.source : "Autore non riconosciuto",
                        style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold)
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

}