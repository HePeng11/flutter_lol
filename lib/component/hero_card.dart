import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/heros_info.dart' as models;

class HeroCard extends StatelessWidget {
  HeroCard({Key key, this.hero, this.no, this.onTap});
  final models.Hero hero;
  final int no;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlugin = new AudioPlayer();
    return Card(
        child: InkWell(
      onTap: () async {
        if (onTap!=null) {
          onTap(this.hero);
        }
        await audioPlugin.play(hero.selectAudio);
      },
      onDoubleTap: () async {
        await audioPlugin.play(hero.banAudio);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: CachedNetworkImage(
                placeholder: (context, url) => new CircularProgressIndicator(),
                imageUrl:
                    'https://game.gtimg.cn/images/lol/act/img/champion/${hero.alias}.png',
                width: ScreenUtil.getInstance().setWidth(120),
                height: ScreenUtil.getInstance().setWidth(120),
              ),
              // child: Image.network(
              //   'https://game.gtimg.cn/images/lol/act/img/champion/${hero.alias}.png',
              //   width: 80,
              //   height: 80,
              // ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      '$no.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      hero.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Text(
                        hero.alias,
                        style: TextStyle(fontSize: 15),
                      ),
                      margin: EdgeInsets.only(left: 10),
                    ),
                  ],
                )),
                Container(
                  child: Row(
                    children: <Widget>[
                      AbilityWidget(
                        name: '攻击力',
                        value: double.parse(hero.attack) / 10,
                        ability: hero.attack,
                        valueColor: Colors.red[200],
                        backgroundColor: Colors.red[50],
                      ),
                      AbilityWidget(
                        name: '法术',
                        value: double.parse(hero.magic) / 10,
                        ability: hero.magic,
                        valueColor: Colors.purple[200],
                        backgroundColor: Colors.purple[50],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      AbilityWidget(
                        name: '防御',
                        value: double.parse(hero.defense) / 10,
                        ability: hero.defense,
                        valueColor: Colors.blue[200],
                        backgroundColor: Colors.blue[50],
                      ),
                      AbilityWidget(
                        name: '难度',
                        value: double.parse(hero.difficulty) / 10,
                        ability: hero.difficulty,
                        valueColor: Colors.cyan[200],
                        backgroundColor: Colors.cyan[50],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class AbilityWidget extends StatelessWidget {
  const AbilityWidget(
      {Key key,
      @required this.value,
      @required this.ability,
      this.valueColor,
      this.backgroundColor,
      @required this.name})
      : super(key: key);
  final double value;
  final Color valueColor;
  final Color backgroundColor;
  final String name;
  final String ability;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              name,
              textAlign: TextAlign.center,
            ),
            width: 50,
          ),
          SizedBox(
            height: 6.0,
            width: ScreenUtil.getInstance().setWidth(100),
            child: new LinearProgressIndicator(
                //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                value: value,
                backgroundColor: backgroundColor,
                valueColor: new AlwaysStoppedAnimation<Color>(valueColor)),
          ),
          Container(
            child: Text(ability),
            margin: EdgeInsets.only(left: 5),
          )
        ],
      ),
    );
  }
}
