import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/components/news_item.dart';
import 'package:flutternews/models/articlesHolder.dart';
import 'package:flutternews/services/api.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {

  News();

  @override
  _NewsState createState() => _NewsState();
}


class _NewsState extends State<News> with TickerProviderStateMixin {

  TabController _tabController;

  static const String GENERAL = "general";
  static const String SPORT = "sport";
  static const String TECHNOLOGY = "technology";
  static const String SCIENCE = "science";

  @override
  void initState() {
    super.initState();
    _tabController = getTabController();
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("assets/logo_app.png",
              height: 100,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.blueGrey,
              tabs: <Widget>[getTabs("Headlines"), getTabs("Sport"), getTabs("Technology"), getTabs("Science")],
              controller: _tabController,
            )),
        body: Container(
            child: TabBarView(controller: _tabController, children: <Widget>[
              Center(
                child: RefreshIndicator(
                  onRefresh: () => _refresh(context, null),
                  child: Consumer<ArticlesHolder>(builder: (context, holder, child) {
                    return ListView.builder(
                      itemCount: holder.articles.length == null ? 0 : holder.articles.length,
                      itemBuilder: (context, position) =>
                      NewsItem(holder.articles[position]));
              })
            )),
              getTabItem(SPORT),
              getTabItem(TECHNOLOGY),
              getTabItem(SCIENCE)
            ]
            )
        )
    );
  }

  TabController getTabController() {
    return TabController(length: 4, vsync: this);
  }

  Tab getTabs(String category) {
    return Tab(
      text: category,
    );
  }

  Center getTabItem(String category){
    return Center(
        child: RefreshIndicator(
            onRefresh: () => _refresh(context, category),
            child: Consumer<ArticlesHolder>(builder: (context, news, child) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  itemCount: news.getArticles(category) == null ? 0 : news.getArticles(category).length,
                  itemBuilder: (context,position) => NewsItem(news.getArticles(category)[position]),
              );
            }
            )
        )
    );
  }


  Future<bool> _refresh(BuildContext context, String category) async {
    await Api().getArticles( context: context,category: category);
    return true;
  }

  void _handleTabSelection() async {
    if (_tabController.index == 1)
      await Api().getArticles(context: context, category: SPORT);
    if (_tabController.index == 2)
      await Api().getArticles(context: context, category: TECHNOLOGY);
    if (_tabController.index == 3)
      await Api().getArticles(context: context, category: SCIENCE);
  }
}
