import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hp_demo1/models/lol_new.dart' as LOLNewModel;
import 'package:hp_demo1/models/lol_swip.dart';
import 'package:hp_demo1/services/homeService.dart';

class HomeBloc {
  ///-----------轮播图片--------------
  List<LOLSwip> _swipImgUrls;
  var _swipImgUrlsController = StreamController<List<LOLSwip>>.broadcast();

  Stream<List<LOLSwip>> get stream => _swipImgUrlsController.stream;
  List<LOLSwip> get swipImgUrls => _swipImgUrls;

  refreshSwipImgUrls(BuildContext context) {
    HomeService().getSwipImages(context).then((result) {
      _swipImgUrls = result;
      _swipImgUrlsController.sink.add(_swipImgUrls);
    });
  }

  ///------------新闻列表---------------
  static Map<int, List<LOLNewModel.Result>> _lolNews =
      new Map<int, List<LOLNewModel.Result>>();
  static Map<int, int> _lolNewPageIndex = new Map();
  var _lolNewController =
      StreamController<Map<int, List<LOLNewModel.Result>>>.broadcast();

  Stream<Map<int, List<LOLNewModel.Result>>> get lolNewStream =>
      _lolNewController.stream;
  Map<int, List<LOLNewModel.Result>> get lolNews => _lolNews;

  void queryLolNews(BuildContext context,
      {int newType = 24, Function queryend, bool refresh = false}) {
    if (refresh) {
      _lolNewPageIndex[newType] = 0;
      _lolNews[newType]?.clear();
    }
    _lolNewPageIndex[newType] = _lolNewPageIndex[newType] ?? 0;
    _lolNewPageIndex[newType] += 1;
    HomeService()
        .getLOLNews(context, newType, _lolNewPageIndex[newType], 15)
        .then((result) {
      _lolNews[newType] = _lolNews[newType] ?? List<LOLNewModel.Result>();
      _lolNews[newType]..addAll(result.data.result);
      print('queryLolNews success=> page $_lolNewPageIndex');
      _lolNewController.sink.add(_lolNews);
      if (queryend != null) {
        queryend();
      }
    }).catchError((e) {
      _lolNewPageIndex[newType] -= 1;
    });
  }

  ///dispose
  dispose() {
    _swipImgUrlsController.close();
    _lolNewController.close();
  }
}
