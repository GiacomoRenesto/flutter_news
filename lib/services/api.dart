
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutternews/models/article.dart';
import 'package:http/http.dart' as http;

const String API = "http://newsapi.org/v2/";
const String TOP_HEADLINES = "top-headlines";
const String COUNTRY = "?country=";
const String CATEGORY = "&category=";
const String API_KEY = "&apiKey=f1c64c01ea214cdaaa24a0dd59a9dfd6";

class Api {

  Future<List<Article>> getArticles({String category}) async {
    http.Client client = new http.Client();
    if(category != null) {
      final response = await client.get(getUrl(category: category));
      // Use the compute function to run parseArticles in a separate isolate.
      return await compute(_parseArticles, response.body);
    }else {
      final response = await client.get(getUrl());
      // Use the compute function to run parseArticles in a separate isolate.
      return await compute(_parseArticles, response.body);
    }

  }

  static List<Article> _parseArticles(String responseBody) {
    final parsed = json.decode(responseBody);

    return parsed["articles"].map<Article>((json) => Article.fromJson(json)).toList();

  }

  String getUrl({String category}){
    String url = API + TOP_HEADLINES;
    if(category != null)
      return url + COUNTRY + "it" + CATEGORY + category + API_KEY;
    return url + COUNTRY + "it" + CATEGORY + "general" + API_KEY;
  }

}