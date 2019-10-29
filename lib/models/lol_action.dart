class LOLActions {
  List<Action> action;

  LOLActions({this.action});

  LOLActions.fromJson(Map<String, dynamic> json) {
    if (json['action'] != null) {
      action = new List<Action>();
      json['action'].forEach((v) {
        action.add(new Action.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.action != null) {
      data['action'] = this.action.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Action {
  String dtBegin;
  String dtEnd;
  String iActId;
  int iDate;
  int iStatus;
  int iJoin;
  String sActDetailUrl;
  String sBigImgUrl;
  String sTopImgUrl;
  String sDescripion;
  String sExtCharOne;
  String sName;
  String sSmallImgUrl;
  String sSmallnewImgUrl;
  String iHotActFlag;

  Action(
      {this.dtBegin,
      this.dtEnd,
      this.iActId,
      this.iDate,
      this.iStatus,
      this.iJoin,
      this.sActDetailUrl,
      this.sBigImgUrl,
      this.sTopImgUrl,
      this.sDescripion,
      this.sExtCharOne,
      this.sName,
      this.sSmallImgUrl,
      this.sSmallnewImgUrl,
      this.iHotActFlag});

  Action.fromJson(Map<String, dynamic> json) {
    dtBegin = json['dtBegin'];
    dtEnd = json['dtEnd'];
    iActId = json['iActId'];
    iDate = json['iDate'];
    iStatus = json['iStatus'];
    iJoin = json['iJoin'];
    sActDetailUrl = json['sActDetailUrl'];
    sBigImgUrl = json['sBigImgUrl'];
    sTopImgUrl = json['sTopImgUrl'];
    sDescripion = json['sDescripion'];
    sExtCharOne = json['sExtCharOne'];
    sName = json['sName'];
    sSmallImgUrl = json['sSmallImgUrl'];
    sSmallnewImgUrl = "https:${json['sSmallnewImgUrl']}";
    iHotActFlag = json['iHotActFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtBegin'] = this.dtBegin;
    data['dtEnd'] = this.dtEnd;
    data['iActId'] = this.iActId;
    data['iDate'] = this.iDate;
    data['iStatus'] = this.iStatus;
    data['iJoin'] = this.iJoin;
    data['sActDetailUrl'] = this.sActDetailUrl;
    data['sBigImgUrl'] = this.sBigImgUrl;
    data['sTopImgUrl'] = this.sTopImgUrl;
    data['sDescripion'] = this.sDescripion;
    data['sExtCharOne'] = this.sExtCharOne;
    data['sName'] = this.sName;
    data['sSmallImgUrl'] = this.sSmallImgUrl;
    data['sSmallnewImgUrl'] = this.sSmallnewImgUrl;
    data['iHotActFlag'] = this.iHotActFlag;
    return data;
  }
}
