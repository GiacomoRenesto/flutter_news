
import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/models/article.dart';
import 'package:flutternews/models/articlesHolder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const String API = "https://newsapi.org/v2/";
const String TOP_HEADLINES = "top-headlines";
const String COUNTRY = "?country=";
const String CATEGORY = "&category=";
const String API_KEY = "f1c64c01ea214cdaaa24a0dd59a9dfd6";

class Api {

  final Dio dio = Dio();
  final DioCacheManager dioCacheManager =
  DioCacheManager(CacheConfig(baseUrl: API));

  Api() {
    dio.options.baseUrl = API;
    dio.options.connectTimeout = 5000;
    dio.transformer = FlutterTransformer();

    if (!kIsWeb) dio.interceptors.add(dioCacheManager.interceptor);

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (options.extra.isNotEmpty) {
        options.queryParameters.addAll(options.extra);
      }
      // Do something before request is sent
      options.queryParameters['apiKey'] = API_KEY;
      options.queryParameters['country'] = "it";
      return options;
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
  }

  Future<List<Article>> getHeadlines() async {
    Response response = await dio.get(TOP_HEADLINES,
        options: buildCacheOptions(Duration(seconds: 30)));

    return response.data['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }

  Future<void> getArticles({@required BuildContext context,String category}) async {
    var articlesHolder = Provider.of<ArticlesHolder>(context, listen: false);
    Response response = await dio.get(TOP_HEADLINES,
    options: buildCacheOptions(Duration(seconds: 30),
    options: Options(extra: createExtras(category))));

    List<Article> news = response.data['articles'].map<Article>((json) => Article.fromJson(json)).toList();
    return articlesHolder.addToArticlesMap(category, news);
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

  Map <String,dynamic> createExtras(String category){
    LinkedHashMap <String, dynamic> map = LinkedHashMap();
    if(category != null) map['category'] = category;
    return map;
  }

}