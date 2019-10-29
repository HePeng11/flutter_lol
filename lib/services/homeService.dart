import 'dart:async' show Future;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hp_demo1/common/datetime_util.dart';
import 'package:hp_demo1/common/logUtil.dart';
import 'package:hp_demo1/models/heros_info.dart' as models;
import 'package:hp_demo1/models/lol_action.dart';
import 'package:hp_demo1/models/lol_new.dart';
import 'package:hp_demo1/models/lol_swip.dart';

import 'localService.dart';

class HomeService {
  final LocalService localService = new LocalService();

  ///获取swip用的图片
  Future<List<LOLSwip>> getSwipImages(context) async {
    print(DatetimeUtil.toLongString(DateTime.now()) + 'getSwipImages');
    try {
      Dio dio = new Dio();
      var response = await dio.get(
          "https://ossweb-img.qq.com/images/clientpop/idata_ad/idata_ad_15282.js");
      var result = response.data.toString().replaceFirst('var gAds15282=', '');
      var list = LOLSwip.fromJsonResult(result);
      localService.setSwip(result);
      return list;
    } catch (e) {
      LogUtil.log(e.message, 'HomeService.getSwipImages', context: context);
      return null;
    }
  }

  ///获取英雄数据
  Future<models.HerosInfo> getHeros(context) async {
    try {
      Dio dio = new Dio();
      var response = await dio.get(
          "https://game.gtimg.cn/images/lol/act/img/js/heroList/hero_list.js");
      //https://game.gtimg.cn/images/lol/act/img/js/hero/2.js
      localService.setHero(response.data);
      return models.HerosInfo.fromJson(json.decode(response.data));
    } catch (e) {
      LogUtil.log(e.message, 'HomeService.getHeros', context: context);
      return models.HerosInfo();
    }
  }

  ///全部活动
  Future<LOLActions> getLOLActions(context) async {
    print(DatetimeUtil.toLongString(DateTime.now()) + 'getSwipImages');
    try {
      Dio dio = new Dio();
      var response = await dio.get(
          "https://ossweb-img.qq.com/images/clientpop/act/lol/lol_act_1_index.js");
      var result =
          response.data.toString().replaceFirst('var action=', '{ "action":');
      result = result.substring(0, result.length - 1);
      LOLActions list = new LOLActions.fromJson(json.decode("$result}"));
      list.action = list.action.sublist(0, 8);
      return list;
    } catch (e) {
      LogUtil.log(e.message, 'HomeService.getSwipImages', context: context);
      return null;
    }
  }

  ///新闻 分页
  ///赛事 https://apps.game.qq.com/cmc/zmMcnTargetContentList?page=2&num=16&target=23
  ///分类： * 1 news 默认,   2 inform 公告 分配给官方及下列  3 event 赛事 分配给赛事及下列 4 amusement 娱乐 ->分配给视频及下列 tutorial 教学 ->分配给教学及下列
  /// sTagIds 默认news 2 1253-1277(视频) 3 1278-1279(娱乐) 4 1280-1284(赛事) 5.1285-1290 (教学) 6.1291-1569 (官方)
  Future<LOLNew> getLOLNews(context, int type, int pi, int ps) async {
    print(DatetimeUtil.toLongString(DateTime.now()) +
        'getLOLNews type:$type pi:$pi ps:$ps');
    try {
      Dio dio = new Dio();
      var response = await dio.get(
          "https://apps.game.qq.com/cmc/zmMcnTargetContentList",
          queryParameters: {"target": type, "page": pi, "num": ps});
      LOLNew list = new LOLNew.fromJson(response.data);
      if (pi == 1) {
        localService.setLoLNews(type, json.encode(list));
      }
      return list;
    } catch (e) {
      LogUtil.log(e.message, 'HomeService.getLOLNews', context: context);
      throw (e);
    }
  }
}
