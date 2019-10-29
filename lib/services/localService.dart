import 'dart:convert';

import 'package:hp_demo1/models/heros_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final String swipKey = 'swip_key';
  final String heroKey = 'hero_key';
  final String loLNewsKey = 'lol_news_Key';

  Future setSwip(String listJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(swipKey, listJson);
  }

  Future<String> getSwip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(swipKey);
  }

  Future setHero(String listJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(heroKey, listJson);
  }

  Future<HerosInfo> getHero() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String r = prefs.getString(heroKey);
    if (r == null || r.isEmpty) {
      return null;
    } else {
      return HerosInfo.fromJson(json.decode(r));
    }
  }

  Future setLoLNews(int type, String listJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('$loLNewsKey$type', listJson);
  }

  Future<String> getLoLNews(int type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('$loLNewsKey$type');
  }
}
