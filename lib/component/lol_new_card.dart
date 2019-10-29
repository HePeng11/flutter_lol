import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hp_demo1/common/logUtil.dart';
import 'package:hp_demo1/component/webView.dart';
import 'package:hp_demo1/models/lol_new.dart';
import 'package:url_launcher/url_launcher.dart';

class LOLNewCard extends StatefulWidget {
  LOLNewCard(this.lolNew);
  final Result lolNew;
  @override
  _LOLNewCardState createState() => _LOLNewCardState();
}

class _LOLNewCardState extends State<LOLNewCard> {
  Color bgColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (detail) {
        setState(() {
          bgColor = Colors.grey[200];
        });
        _showMenu(context, detail);
      },
      onTap: () {
        var url = _getNewUrl();
        _openUrlLocal(url, widget.lolNew.sTitle);
      },
      child: Container(
        color: bgColor,
        height: ScreenUtil.instance.setHeight(170),
        padding: EdgeInsets.only(
            top: ScreenUtil.instance.setWidth(10),
            bottom: ScreenUtil.instance.setWidth(10),
            left: ScreenUtil.instance.setWidth(20),
            right: ScreenUtil.instance.setWidth(20)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                    placeholder: (context, url) => new SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 13,
                        ),
                    imageUrl: 'https:${widget.lolNew.sIMG}',
                    height: ScreenUtil.instance.setHeight(130),
                    width: ScreenUtil.instance.setWidth(35),
                    fit: BoxFit.fill),
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.lolNew.sTitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    constraints: BoxConstraints(
                        minHeight: ScreenUtil.instance.setHeight(50)),
                    width: ScreenUtil.instance.setWidth(480),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: ScreenUtil.instance.setWidth(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.lolNew.sAuthor,
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 10),
                        ),
                        Text(
                          '  点击量: ${widget.lolNew.iTotalPlay}',
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 10),
                        )
                      ],
                    ),
                  )
                ],
              ),
              flex: 5,
            )
          ],
        ),
      ),
    );
  }

  PopupMenuButton _popMenu() {
    return PopupMenuButton(
      itemBuilder: (context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            value: 1,
            child: Text('应用内打开'),
          ),
          PopupMenuItem(
            value: 2,
            child: Text('浏览器打开'),
          ),
        ];
      },
      onSelected: (value) async {
        setState(() {
          bgColor = Colors.white;
        });
        var url = _getNewUrl();
        if (value == 1) {
          //应用内打开
          _openUrlLocal(url, widget.lolNew.sTitle);
        } else {
          //浏览器打开
          _openUrl(url);
        }
      },
      onCanceled: () {
        setState(() {
          bgColor = Colors.white;
        });
      },
    );
  }

  void _openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      LogUtil.log('can not laubch $url', 'LOLNewCard.PopupMenuButton');
    }
  }

  void _openUrlLocal(url, title) async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return WebViewPlugin(url, title: title);
    }));
  }

  _showMenu(BuildContext context, LongPressStartDetails detail) {
    // RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    // var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    //注意提示框高度
    var dy =
        detail.globalPosition.dy > (MediaQuery.of(context).size.height - 100)
            ? (MediaQuery.of(context).size.height - 200)
            : detail.globalPosition.dy;
    final RelativeRect position = RelativeRect.fromLTRB(
        detail.globalPosition.dx, //取点击位置坐弹出x坐标
        dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        detail.globalPosition.dx,
        dy);
    var pop = _popMenu();
    showMenu(
      context: context,
      items: pop.itemBuilder(context),
      position: position, //弹出框位置
    ).then((newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  String _getNewUrl() {
    var url = "";
    if (widget.lolNew.sRedirectURL != null &&
        widget.lolNew.sRedirectURL.isNotEmpty &&
        widget.lolNew.sRedirectURL != "") {
      var href = widget.lolNew.sRedirectURL;
      if (href.indexOf('docid') <= 0) {
        if (href.indexOf('?') > 0) {
          url = href + '&docid=' + widget.lolNew.iDocID;
        } else {
          url = href + '?docid=' + widget.lolNew.iDocID;
        }
      }
    } else {
      if (widget.lolNew.sVID != null &&
          widget.lolNew.sVID.isNotEmpty &&
          widget.lolNew.sVID != "") {
        url = 'https://lol.qq.com/v/v2/detail.shtml?docid=' +
            widget.lolNew.iDocID;
      } else {
        //拼接为个人中心详情页
        url = 'https://lol.qq.com/news/detail.shtml?docid=' +
            widget.lolNew.iDocID;
      }
    }
    return url;
  }
}
