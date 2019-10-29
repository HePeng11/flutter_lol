import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hp_demo1/common/logUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class SwiperDIY extends StatelessWidget {
  SwiperDIY(Key key, this.list) : super(key: key);
  final List list;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.green[100]
      ),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          // return new Image.network(
          //   list[index].toString(),
          //   fit: BoxFit.fill,
          // );
          return GestureDetector(
            onTap: () async {
              if (await canLaunch(list[index][1])) {
                await launch(list[index][1]);
              } else {
                LogUtil.log('can not laubch ${list[index][1]}',
                    'DIY_Swiper.GestureDetector');
              }
            },
            child: new CachedNetworkImage(
                placeholder: (context, url) => new SpinKitWave(
                      color: Theme.of(context).accentColor,
                    ),
                imageUrl: list[index][0],
                fit: BoxFit.fill),
          );
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: true,
        autoplayDelay: 3000,
        itemCount: list.length,
        pagination: new SwiperPagination(),
        fade: 0.8,
        viewportFraction: 0.7,
        scale: 0.8,
      ),
    );
  }
}
