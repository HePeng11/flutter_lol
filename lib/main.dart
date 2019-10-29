import 'package:flutter/material.dart';
import 'consts/app_config.dart';
import 'routes/SplanshScreen.dart';
import 'consts/routeConst.dart';
import 'routes/frame_page.dart';
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppRoute();
  }
}

class MyAppRoute extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RouteConst.main_page: (ctx) {
          return FramePage(
            title: '',
          );
        },
        // RouteConst.indroduce_page: (ctx) {
        //   return IndroducePage();
        // },
      },
      theme: ThemeData(
          primaryColor: AppConfig.themePrimaryColor,
          accentColor: AppConfig.themePrimaryColor),
      home: SplanshScreen(5),
    );
  }
}