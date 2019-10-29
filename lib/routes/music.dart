import 'package:flutter/material.dart';
import 'package:hp_demo1/component/otherLibs/flutter_radial_menu-master/lib/flutter_radial_menu.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class Music extends StatefulWidget {
  @override
  State createState() => _PopupMenuState();
}

enum MenuOptions {
  weixin,
  zhifubao,
  archive,
  delete,
  backup,
  copy,
}

class _PopupMenuState extends State {
  GlobalKey<RadialMenuState> _menuKey = new GlobalKey<RadialMenuState>();

  final List<RadialMenuItem<MenuOptions>> items = <RadialMenuItem<MenuOptions>>[
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.weixin,
      // child: new Icon(
      //   Icons.markunread,
      // ),
      child: new Image.asset(
        "assets/images/icon_wx.png",
        width: 60.0,
        height: 60.0,
      ),
      // iconColor: Colors.white,
      backgroundColor: Colors.blue[50],
      tooltip: 'unread',
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.zhifubao,
      child: Image.asset(
        "assets/images/支付宝.png",
        color: Colors.white,
      ),
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.archive,
      child: new Icon(
        Icons.archive,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.yellow[400],
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.delete,
      child: new Icon(
        Icons.delete,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.red[400],
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.backup,
      child: new Icon(
        Icons.backup,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.copy,
      child: new Icon(
        Icons.content_copy,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.indigo[400],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new RadialMenu(
          key: _menuKey,
          items: items,
          radius: 100.0,
          onSelected: _onItemSelected,
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.restore),
        onPressed: () => _menuKey.currentState.reset(),
      ),
    );
  }

  @override
  void initState() {
    _initFluwx();
    super.initState();
  }

  _initFluwx() async {
    await fluwx.registerWxApi(
        appId: "wxd930ea5d5a258f4f",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://your.univerallink.com/link/");
    var result = await fluwx.isWeChatInstalled();
    print("is installed $result");
    fluwx.responseFromAuth.listen((data) {
      print(data);
    });
  }

  void _onItemSelected(dynamic value) {
    print(value);
    switch (value) {
      case MenuOptions.weixin:
        _callOpenWX();
        break;
      default:
    }
  }

  /// login WX
  _callOpenWX() {
    fluwx
        .sendAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
        .then((data) {
      print(data);
    });
  }

  // Color bgColor = Colors.white;
  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: Text(
  //         'popmenu～～～',
  //         style: TextStyle(backgroundColor: bgColor, height: 1.5, fontSize: 15),
  //       ),
  //     ),
  //     onLongPressStart: (detail) {
  //       bgColor = Colors.grey;
  //       setState(() {});
  //       _showMenu(context, detail);
  //     },
  //   );
  // }

  // PopupMenuButton _popMenu() {
  //   return PopupMenuButton(
  //     itemBuilder: (context) {
  //       return <PopupMenuEntry>[
  //         PopupMenuItem(
  //           value: '复制',
  //           child: Text('复制'),
  //         ),
  //         PopupMenuItem(
  //           value: '收藏',
  //           child: Text('收藏'),
  //         ),
  //       ];
  //     },
  //     onSelected: (value) {
  //       print('onSelected');
  //       _selectValueChange(value);
  //     },
  //     onCanceled: () {
  //       print('onCanceled');
  //       bgColor = Colors.white;
  //       setState(() {});
  //     },
  //   );
  // }

  // _selectValueChange(String value) {
  //   setState(() {});
  // }

  // _showMenu(BuildContext context, LongPressStartDetails detail) {
  //   // RenderBox renderBox = anchorKey.currentContext.findRenderObject();
  //   // var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
  //   print(ScreenUtil.instance.height);
  //   final RelativeRect position = RelativeRect.fromLTRB(
  //       detail.globalPosition.dx, //取点击位置坐弹出x坐标
  //       detail.globalPosition.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
  //       detail.globalPosition.dx,
  //       detail.globalPosition.dy);
  //   //MediaQuery.of(context).size
  //   var pop = _popMenu();
  //   showMenu(
  //     context: context,
  //     items: pop.itemBuilder(context),
  //     position: position, //弹出框位置
  //   ).then((newValue) {
  //     if (!mounted) return null;
  //     if (newValue == null) {
  //       if (pop.onCanceled != null) pop.onCanceled();
  //       return null;
  //     }
  //     if (pop.onSelected != null) pop.onSelected(newValue);
  //   });
  // }
}
