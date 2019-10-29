import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hp_demo1/common/routeUtil.dart';
import 'package:hp_demo1/consts/app_config.dart';
import 'package:hp_demo1/routes/login.dart';
import '../component/otherLibs/inner_drawer/inner_drawer.dart';
import '../consts/routeConst.dart';
import 'hero_list.dart';
import 'home.dart';
import 'logview.dart';
import 'music.dart';
import 'indroducePage.dart';
import '../bloc/countBloc.dart';

class FramePage extends StatefulWidget {
  FramePage({Key key, this.title}) : super(key: key);

  final String title;
  static final GlobalKey<InnerDrawerState> innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  _FramePageState createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  // @override
  // bool get wantKeepAlive => true;

  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    new HerosView(),
    new Music(),
    new IndroducePage()
  ];

  final Map<IconData, String> _tabList = {
    Icons.home: '资讯',
    Icons.account_box: '英雄',
    Icons.apps: 'go_other',
    Icons.insert_comment: 'indroduce'
  };
  

  void onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return BlocProvider(
      child: MaterialApp(
        home: _buildDrawer(_buildFrame()),
        theme: ThemeData(
            primaryColor: AppConfig.themePrimaryColor,
            accentColor: AppConfig.themePrimaryColor),
        routes: {
          RouteConst.log_page: (ctx) {
            return LogView();
          },
        },
      ),
    );
  }

  Widget _buildFrame() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: _tabList.keys.map((f) {
          return BottomNavigationBarItem(
            icon: Icon(f),
            title: Text(_tabList[f]),
          );
        }).toList(),
      ),
      body: IndexedStack(
        children: _children,
        index: _currentIndex,
      ),
    );
  }

  Widget _buildDrawer(Widget child) {
    return InnerDrawer(
        leftChild: Material(
            color: AppConfig.themePrimaryColor,
            child: Container(
              margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    left: BorderSide(width: 1, color: Colors.grey[200]),
                    right: BorderSide(width: 1, color: Colors.grey[200])),
              ),
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircleAvatar(
                                      child: Icon(Icons.person,
                                          color: Colors.white, size: 12),
                                      backgroundColor:
                                          AppConfig.themePrimaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        FramePage.innerDrawerKey.currentState.toggle();
                                        RouteUtil.goto(context, LoginPage());
                                      },
                                      child: Text(
                                        "未登录",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            height: 1.2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2, right: 25),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 18,
                                  ),
                                  onTap: () {
                                    FramePage.innerDrawerKey.currentState
                                        .toggle();
                                  },
                                ),
                              ),
                            ],
                          )),
                      Divider(),
                      ListTile(
                        title: Text("Statistics"),
                        leading: Icon(Icons.show_chart),
                      ),
                      ListTile(
                        title: Text("Activity"),
                        leading: Icon(Icons.access_time),
                      ),
                      ListTile(
                        title: Text("Nametag"),
                        leading: Icon(Icons.rounded_corner),
                      ),
                      ListTile(
                        title: Text("Favorite"),
                        leading: Icon(Icons.bookmark_border),
                      ),
                      ListTile(
                        title: Text("Close Friends"),
                        leading: Icon(Icons.list),
                      ),
                      ListTile(
                        title: Text("Suggested People"),
                        leading: Icon(Icons.person_add),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (ctx) {
                      return Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(ctx).size.width,
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            decoration: BoxDecoration(
                                //color: Colors.grey,
                                border: Border(
                                    top: BorderSide(
                              color: AppConfig.themePrimaryColor,
                            ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  size: 18,
                                ),
                                Text(
                                  "  Settings",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ));
                    },
                  )
                ],
              ),
            )),
        key: FramePage.innerDrawerKey,
        onTapClose: false,
        tapScaffoldEnabled: true,
        leftOffset: 0.2,
        // swipe: true,
        colorTransition: AppConfig.themePrimaryColor,
        leftAnimationType: InnerDrawerAnimation.static,
        innerDrawerCallback: (a) => print('innerDrawerCallback $a'),
        scaffold: child);
  }
}
