import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import '../utils/imageUtils.dart';
class IndroducePage extends StatelessWidget {
  final pages = [
    PageViewModel(
        pageColor: Colors.red[200],
        iconImageAssetPath: ImageUtils.getImgPath('air-hostess'), //圆点图标
        body: Text(
          '可设置长宽、居中、背景色',
        ),
        title: Text(
          '下面这个是主图片',
          style: TextStyle(fontSize: 25),
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          ImageUtils.getImgPath('airplane'),
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Colors.green[200],
      iconImageAssetPath: ImageUtils.getImgPath('waiter'), //圆点图标
      body: Text(
        '下面这个是圆点图标',
      ),
      title: Text(''),
      mainImage: Image.asset(
        ImageUtils.getImgPath('hotel'),
        height: 285.0,
        width: 285.0,
        alignment: Alignment.topCenter,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: Colors.teal[200],
      iconImageAssetPath: ImageUtils.getImgPath('taxi-driver'),
      body: Text(
        'showSkipButton=false',
        style: TextStyle(fontSize: 14),
      ),
      title: Text('开启美好生活吧'),
      mainImage: Image.asset(
        ImageUtils.getImgPath('taxi'),
        // height: 285.0,
        // width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        onTapDoneButton: () {
          // Navigator.of(context).pushReplacementNamed(RouteConst.main_page);
        },
        showSkipButton: false,
        skipText: Text('跳过'),
        doneText: Text('完成'),
        pageButtonTextStyles: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    );
  }
}
