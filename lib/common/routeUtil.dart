import 'package:flutter/material.dart';

class RouteUtil {
  static void goto(BuildContext context, Widget page) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}
