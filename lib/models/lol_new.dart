class LOLNew {
  Data data;
  String from;
  String msg;
  int status;

  LOLNew({this.data, this.from, this.msg, this.status});

  LOLNew.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    from = json['from'];
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['from'] = this.from;
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<Result> result;
  int resultNum;
  int resultPage;
  int resultTotal;

  Data({this.result, this.resultNum, this.resultPage, this.resultTotal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    resultNum = json['resultNum'];
    resultPage = json['resultPage'];
    resultTotal = json['resultTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['resultNum'] = this.resultNum;
    data['resultPage'] = this.resultPage;
    data['resultTotal'] = this.resultTotal;
    return data;
  }
}

class Result {
  String authorID;
  String avatar;
  String iDocID;
  String iNewsId;
  String iSourceId;
  String iTotalPlay;
  String sAuthor;
  String sCreated;
  String sIMG;
  String sIdxTime;
  String sTagIds;
  String sTitle;
  String sRedirectURL;
  String sVID;
  

  Result(
      {this.authorID,
      this.avatar,
      this.iDocID,
      this.iNewsId,
      this.iSourceId,
      this.iTotalPlay,
      this.sAuthor,
      this.sCreated,
      this.sIMG,
      this.sIdxTime,
      this.sTagIds,
      this.sRedirectURL,
      this.sVID,
      this.sTitle});

  Result.fromJson(Map<String, dynamic> json) {
    authorID = json['authorID'];
    avatar = json['avatar'];
    iDocID = json['iDocID'];
    iNewsId = json['iNewsId'];
    iSourceId = json['iSourceId'];
    iTotalPlay = json['iTotalPlay'];
    sAuthor = json['sAuthor'];
    sCreated = json['sCreated'];
    sIMG = json['sIMG'];
    sIdxTime = json['sIdxTime'];
    sTagIds = json['sTagIds'];
    sTitle = json['sTitle'];
    sRedirectURL = json['sRedirectURL'];
    sVID = json['sVID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorID'] = this.authorID;
    data['avatar'] = this.avatar;
    data['iDocID'] = this.iDocID;
    data['iNewsId'] = this.iNewsId;
    data['iSourceId'] = this.iSourceId;
    data['iTotalPlay'] = this.iTotalPlay;
    data['sAuthor'] = this.sAuthor;
    data['sCreated'] = this.sCreated;
    data['sIMG'] = this.sIMG;
    data['sIdxTime'] = this.sIdxTime;
    data['sTagIds'] = this.sTagIds;
    data['sTitle'] = this.sTitle;
    data['sRedirectURL'] = this.sRedirectURL;
    data['sVID'] = this.sVID;
    return data;
  }
}
