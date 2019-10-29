import 'dart:convert';

class LOLSwip {
  String adId;
  String actionID;
  String fname;
  String bannerId;
  String popWidth;
  String popHeight;
  String imgUrl;
  String adUrl;
  String beginTime;
  String endTime;
  String ecode;
  String adMemo;
  String type;
  String isBottom;
  String dataVesion;

  LOLSwip(
      {this.adId,
      this.actionID,
      this.fname,
      this.bannerId,
      this.popWidth,
      this.popHeight,
      this.imgUrl,
      this.adUrl,
      this.beginTime,
      this.endTime,
      this.ecode,
      this.adMemo,
      this.type,
      this.isBottom,
      this.dataVesion});

  LOLSwip.fromJson(Map<String, dynamic> json) {
    adId = json['adId'];
    actionID = json['actionID'];
    fname = json['Fname'];
    bannerId = json['bannerId'];
    popWidth = json['popWidth'];
    popHeight = json['popHeight'];
    imgUrl = "https:${json['imgUrl']}";
    adUrl = json['adUrl'];
    beginTime = json['beginTime'];
    endTime = json['endTime'];
    ecode = json['ecode'];
    adMemo = json['ad_memo'];
    type = json['type'];
    isBottom = json['isBottom'];
    dataVesion = json['data_vesion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adId'] = this.adId;
    data['actionID'] = this.actionID;
    data['Fname'] = this.fname;
    data['bannerId'] = this.bannerId;
    data['popWidth'] = this.popWidth;
    data['popHeight'] = this.popHeight;
    data['imgUrl'] = this.imgUrl;
    data['adUrl'] = this.adUrl;
    data['beginTime'] = this.beginTime;
    data['endTime'] = this.endTime;
    data['ecode'] = this.ecode;
    data['ad_memo'] = this.adMemo;
    data['type'] = this.type;
    data['isBottom'] = this.isBottom;
    data['data_vesion'] = this.dataVesion;
    return data;
  }

  static List<LOLSwip> fromJsonResult(String result) {
    List<LOLSwip> list = new List<LOLSwip>();
    for (var item in (json.decode("$result")["common"] as Map).values) {
      list.add(LOLSwip.fromJson(item));
    }
    return list;
  }
}
