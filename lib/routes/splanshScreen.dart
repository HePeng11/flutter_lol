import 'package:flutter/material.dart';
import '../utils/imageUtils.dart';
import '../consts/routeConst.dart';
import 'package:common_utils/common_utils.dart';

class SplanshScreen extends StatefulWidget {
  SplanshScreen(this.seconds);
  final int seconds;
  @override
  _SplanshScreenState createState() => new _SplanshScreenState();
}

class _SplanshScreenState extends State<SplanshScreen> {
  int _count = 3;
  TimerUtil _timerUtil;
  @override
  void initState() {
    super.initState();
    _timerUtil = new TimerUtil(mTotalTime: widget.seconds * 1000);
    _timerUtil.setOnTimerTickCallback((t) {
      double _tick = t / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goHome();
      }
    });
    _timerUtil.startCountDown();
  }

  _goHome() {
    _timerUtil.cancel();
    Navigator.of(context).pushReplacementNamed(RouteConst.main_page);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      ImageUtils.getImgPath('start_page', format: 'jpg')),
                  fit: BoxFit.cover)),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(30, 30, 10, 130),
          // padding: EdgeInsets.all(5),
          child: InkWell(
            onTap: () {
              _goHome();
            },
            child: new Container(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 12, 5),
                child: new Text(
                  '跳过 $_count',
                  style: new TextStyle(fontSize: 13.0, color: Colors.white),
                ),
                decoration: new BoxDecoration(
                    color: Color(0x66000000),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        new Border.all(width: 0.33, color: Colors.black12))),
          ),
        )
      ],
    ));
  }
}
