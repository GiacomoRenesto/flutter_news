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
              getTabItem(GENERAL),
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
                  itemCount: news.articles.length,
                  itemBuilder: (context,position) => NewsItem(news.articles[position]),
//                  itemBuilder: (context, position) => GestureDetector(
//                      onTap: () {
//                        Provider.of<ArticlesHolder>(context, listen: false).setSelectedArticle = news.articles[position];
//                        Navigator.pushNamed(context, '/news_web_detail');
//                      },
//                      child: Card(
//                        child: Stack(
//                          alignment: Alignment.bottomLeft,
//                          children: <Widget>[
//                            Card(
//                                child: ClipRRect(
//                                  child:Image.network(
//                                    news.articles[position].urlToImage != null ? news.articles[position].urlToImage : "https://via.placeholder.com/250",
//                                    fit: BoxFit.cover,
//                                  ),
//                                  borderRadius: BorderRadius.circular(12.0),
//                                )
//                            ),
//                            Container(
//                                color: Colors.transparent,
//                                padding: const EdgeInsets.all(8.0),
//                                child: ListTile(
////                                  leading: Text(news.articles[position].source + " " + news.articles[position].publishedAt),
//                                  title: Text(news.articles[position].title,
//                                    style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)
//                                  ),
//                                  subtitle: Text(news.articles[position].source != null ? news.articles[position].source : "Autore non riconosciuto",
//                                    style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold)
//                                  ),
//                                )
//                            )
//                          ],
//                        ),
//                      )
//                  )
              );
            }
            )
        )
    );
  }


  Future<bool> _refresh(BuildContext context, String category) async {
    await Api().getArticles(category: category);
    return true;
  }

  void _handleTabSelection() async {
    if (_tabController.index == 1)
      await Api().getArticles( category: SPORT);
    if (_tabController.index == 2)
      await Api().getArticles( category: TECHNOLOGY);
    if (_tabController.index == 3)
      await Api().getArticles( category: SCIENCE);
  }
}
