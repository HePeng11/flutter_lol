import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hp_demo1/bloc/countBloc.dart';
import 'package:hp_demo1/bloc/homeBloc.dart';
import 'package:hp_demo1/common/datetime_util.dart';
import 'package:hp_demo1/component/lol_new_card.dart';
import 'package:hp_demo1/component/refresh_custome_scroll.dart';
import 'package:hp_demo1/models/lol_swip.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../services/homeService.dart';
import '../component/swiper_diy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'logview.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  HomeService homeService = new HomeService();
  ScrollController _scrollController = new ScrollController();
  bool showToTopBtn = false;
  HomeBloc homeBloc;
  bool initData = false;
  TabController _tabController;
  List _tabs = <Widget>[
    Tab(text: '公告'),
    Tab(text: '赛事'),
    Tab(text: '攻略'),
  ];
  @override
  void initState() {
    print('home_init');
    _tabController = new TabController(vsync: this, length: _tabs.length);
    super.initState();
    _addListener();
  }

  void _addListener() {
    _scrollController.addListener(() {
      print('${_scrollController.offset}');
      print(showToTopBtn);
      if (_scrollController.offset < 150 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 150 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  ///body部分
  @override
  Widget build(BuildContext context) {
    if (!initData) {
      initData = true;
      homeBloc = BlocProvider.getHomeBloc(context);
      homeBloc.refreshSwipImgUrls(context);
      homeBloc.queryLolNews(context, newType: 24);
      homeBloc.queryLolNews(context, newType: 25);
      homeBloc.queryLolNews(context, newType: 27);
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
      body:
          // NestedScrollView(
          //   //CustomScrollView下面只能放sliver 放futurebuilder会报错
          //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
          //       <Widget>[
          //     _buildSliverAppBar(),
          //     _buildTabHeaders(),
          //   ],
          //   body: _buildLOLNewsTabBarView(),
          //   controller: _scrollController,
          // ),
          CustomScrollView(
        //CustomScrollView下面只能放sliver 放futurebuilder会报错
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildTabHeaders(),
          _buildLOLNewsTabBarView()
        ],
        controller: _scrollController,
      ),
      floatingActionButton: showToTopBtn
          ? FloatingActionButton(
              heroTag:
                  'home_float_btn_${DatetimeUtil.toLongString(DateTime.now())}',
              onPressed: () {
                _scrollController.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: ScreenUtil.instance.setHeight(350),
      brightness: Brightness.dark,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildFlexibleSpaceBar(),
        collapseMode: CollapseMode.none,
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
            color: Colors.white10,
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

  ///TabBar头部
  Widget _buildTabHeaders() {
    return SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: _SliverAppBarDelegate(
          TabBar(
            controller: _tabController,
            labelColor: Colors.black54,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.teal,
            indicatorWeight: 1,
            // labelStyle: TextStyle(fontSize: 14),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: _tabs,
          ),
        ));
  }

  ///新闻部分
  Widget _buildLOLNewsTabBarView() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildLOLNews(24),
          _buildLOLNews(25),
          _buildLOLNews(27),
        ],
      ),
    );
  }

  ///新闻部分
  Widget _buildLOLNews1(int newType) {
    return SliverFixedExtentList(
      itemExtent: ScreenUtil.instance.setHeight(180),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return LOLNewCard(homeBloc.lolNews[newType][index]);
      }, childCount: homeBloc.lolNews[newType].length),
    );
  }

  ///新闻部分
  Widget _buildLOLNews(int newType) {
    return StreamBuilder(
      key: UniqueKey(),
      stream: homeBloc.lolNewStream,
      initialData: homeBloc.lolNews,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children = new List();
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data[newType] == null) {
          children.add(Center(
            child: SpinKitCircle(
              color: Colors.blue,
            ),
          ));
        } else {
          snapshot.data[newType].forEach((f) {
            children.add(LOLNewCard(f));
            children.add(Divider(
              indent: ScreenUtil.instance.setWidth(80),
              endIndent: ScreenUtil.instance.setWidth(80),
              height: 2,
              color: Colors.cyan[200],
            ));
          });
          if (children.length > 0 && children.last is Divider) {
            children.removeLast();
          }
        }
        return RefreshCustomeScroll(
          key: UniqueKey(),
          child: ListView(
            children: children,
          ),
          refresh: (RefreshController _refreshController) {
            homeBloc.queryLolNews(context, newType: newType, refresh: true,
                queryend: () {
              print('refresh $newType');
              _refreshController.refreshCompleted();
            });
          },
          loadMore: (RefreshController _refreshController) {
            homeBloc.queryLolNews(context, newType: newType, queryend: () {
              print('loadMore $newType');
              _refreshController.loadComplete();
            });
          },
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => ScreenUtil.instance.setHeight(50);

  @override
  double get maxExtent => ScreenUtil.instance.setHeight(50);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: ScreenUtil.instance.setHeight(50),
      color: Colors.teal[50],
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
