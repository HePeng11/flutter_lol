import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hp_demo1/bloc/countBloc.dart';
import 'package:hp_demo1/bloc/homeBloc.dart';
import 'package:hp_demo1/common/datetime_util.dart';
import 'package:hp_demo1/component/lol_new_card.dart';
import 'package:hp_demo1/component/refresh_custome_scroll.dart';
import 'package:hp_demo1/component/sliverAppBar.dart';
import 'package:hp_demo1/models/lol_swip.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../services/homeService.dart';
import '../component/swiper_diy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'logview.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  HomeService homeService = new HomeService();
  HomeBloc homeBloc;
  bool initData = false;
  TabController _tabController;
  @override
  void initState() {
    print('home_init');
    _tabController = new TabController(vsync: this, length: 3);
    super.initState();
  }

  ///body部分
  final Iterable<Widget> partWidgets = [
    SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: SliverAppBarDelegate(
          minHeight: 50, //收起的高度
          maxHeight: 50, //展开的最大高度
          child: Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text("浮动", style: TextStyle(fontSize: 18)),
          )),
    ),
    SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: new SliverGrid(
        //Grid
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Grid按两列显示
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            //创建子widget
            return new Container(
              alignment: Alignment.center,
              color: Colors.cyan[100 * (index % 9)],
              child: new Text('grid item $index'),
            );
          },
          childCount: 20,
        ),
      ),
    ),
    // List
    new SliverFixedExtentList(
      itemExtent: 50.0,
      delegate:
          new SliverChildBuilderDelegate((BuildContext context, int index) {
        //创建列表项
        return new Container(
          alignment: Alignment.center,
          color: Colors.lightBlue[100 * (index % 9)],
          child: new Text('list item $index'),
        );
      }, childCount: 50 //50个列表项
              ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (!initData) {
      initData = true;
      homeBloc = BlocProvider.getHomeBloc(context);
      homeBloc.refreshSwipImgUrls(context);
      homeBloc.queryLolNews(context);
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text('home'),
        actions: <Widget>[
          RawMaterialButton(
            child: Icon(Icons.error),
            highlightColor: Colors.teal[100],
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return LogView();
              }));
            },
          )
        ],
      ),
      body: RefreshCustomeScroll(
        // child: NestedScrollView(
        //   headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
        //     return [
        //       SliverAppBar(
        //         expandedHeight: 200.0,
        //         flexibleSpace: _buildFlexibleSpaceBar(),
        //       )
        //     ];
        //   },
        //   body: _buildLOLNews(),
        // ),

        child: ListView(
          children: <Widget>[
            _buildFlexibleSpaceBar(),
            StickyHeader(
              header: Container(
                height: 20.0,
                color: Colors.cyan[100],
                padding: new EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    new Text(
                      'Header',
                    ),
                    VerticalDivider(
                      color: Colors.blue,
                    ),
                    new Text(
                      'Header',
                    ),
                  ],
                ),
              ),
              content: _buildLOLNews(),
            ),
          ],
        ),

        // child: CustomScrollView(
        //   //CustomScrollView下面只能放sliver 放futurebuilder会报错
        //   slivers: <Widget>[
        //     SliverAppBar(
        //       expandedHeight: 200.0,
        //       flexibleSpace: _buildFlexibleSpaceBar(),
        //     ),
        //     _buildLOLNews(),
        //   ]..addAll(partWidgets),
        // ),
        refresh: (RefreshController _refreshController) {
          Future.delayed(Duration(milliseconds: 10000)).then((_) {
            print('refresh');
            _refreshController.refreshCompleted();
          });
        },
        loadMore: (RefreshController _refreshController) {
          Future.delayed(Duration(milliseconds: 10000)).then((_) {
            print('loadMore');
            _refreshController.loadComplete();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'home_float_btn_${DatetimeUtil.toLongString(DateTime.now())}',
        key: UniqueKey(),
        onPressed: () => homeBloc.refreshSwipImgUrls(context),
        child: Icon(Icons.arrow_upward),
      ),
    );
  }

  ///轮滑图片部分
  Widget _buildFlexibleSpaceBar() {
    return Container(
      child: StreamBuilder(
        stream: homeBloc.stream,
        initialData: homeBloc.swipImgUrls,
        builder: (BuildContext context, AsyncSnapshot<List<LOLSwip>> snapshot) {
          return Container(
            height: ScreenUtil.instance.setHeight(400),
            child: (homeBloc.swipImgUrls != null &&
                    homeBloc.swipImgUrls.length > 0)
                ? SwiperDIY(
                    UniqueKey(),
                    homeBloc.swipImgUrls
                        .map((f) => [f.imgUrl, f.adUrl])
                        .toList())
                : SpinKitChasingDots(
                    color: Colors.white,
                  ),
          );
        },
      ),
    );
  }

  ///新闻部分
  Widget _buildLOLNews() {
    // return new SliverFixedExtentList(
    //   itemExtent: 50.0,
    //   delegate:
    //       new SliverChildBuilderDelegate((BuildContext context, int index) {
    //     //创建列表项
    //     return new Container(
    //       alignment: Alignment.center,
    //       color: Colors.lightBlue[100 * (index % 9)],
    //       child: new Text('list item $index'),
    //     );
    //   }, childCount: 50),
    // );

    return StreamBuilder(
      stream: homeBloc.lolNewStream,
      initialData: homeBloc.lolNews,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children = new List();
        if (!snapshot.hasData) {
          children.add(Center(
            child: SpinKitCircle(
              color: Colors.blue,
            ),
          ));
        } else {
          snapshot.data.forEach((f) {
            children.add(LOLNewCard(f));
            children.add(Divider(
              indent: ScreenUtil.instance.setWidth(80),
              endIndent: ScreenUtil.instance.setWidth(80),
              color: Colors.cyan[200],
            ));
          });
          children.removeAt(children.length - 1);
        }
        //只有返回column才能和其它组件粘连在一起 用customscroll又不能组合非sliver组件
        return Column(
          children: children,
        );
      },
    );
  }
}
