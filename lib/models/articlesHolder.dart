

import 'package:flutter/cupertino.dart';
import 'package:flutternews/services/api.dart';

import 'article.dart';

class ArticlesHolder extends ChangeNotifier{

  ArticlesHolder(){
    Api api = new Api();
    api.getHeadlines().then((value) => articles=value);
  }

  final List<Article> _articles = [];
  final Map<String, List<Article>> _articlesMap = Map();

  Article selectedArticle;

  Article get getSelectedArticle => selectedArticle;

  set setSelectedArticle(Article article){ selectedArticle = article;}

  set articles(List<Article> news){
    _articles.clear();
    _articles.addAll(news);
    notifyListeners();
  }

  void addToArticlesMap(String key, List<Article> news) {
    assert(news != null);
    _articlesMap[key] = news;
    notifyListeners();
  }

  List<Article> getArticles(String category) => _articlesMap[category];

  List<Article> get articles => _articles;
}