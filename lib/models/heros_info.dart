class HerosInfo {
  List<Hero> hero;
  String version;
  String fileName;
  String fileTime;

  HerosInfo({this.hero, this.version, this.fileName, this.fileTime});

  HerosInfo.fromJson(Map<String, dynamic> json) {
    if (json['hero'] != null) {
      hero = new List<Hero>();
      json['hero'].forEach((v) {
        hero.add(new Hero.fromJson(v));
      });
    }
    version = json['version'];
    fileName = json['fileName'];
    fileTime = json['fileTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hero != null) {
      data['hero'] = this.hero.map((v) => v.toJson()).toList();
    }
    data['version'] = this.version;
    data['fileName'] = this.fileName;
    data['fileTime'] = this.fileTime;
    return data;
  }
}

class Hero {
  String heroId;
  String name;
  String alias;
  String title;
  List<String> roles;
  String isWeekFree;
  String attack;
  String defense;
  String magic;
  String difficulty;
  String selectAudio;
  String banAudio;

  Hero(
      {this.heroId,
      this.name,
      this.alias,
      this.title,
      this.roles,
      this.isWeekFree,
      this.attack,
      this.defense,
      this.magic,
      this.difficulty,
      this.selectAudio,
      this.banAudio});

  Hero.fromJson(Map<String, dynamic> json) {
    heroId = json['heroId'];
    name = json['name'];
    alias = json['alias'];
    title = json['title'];
    roles = json['roles'].cast<String>();
    isWeekFree = json['isWeekFree'];
    attack = json['attack'];
    defense = json['defense'];
    magic = json['magic'];
    difficulty = json['difficulty'];
    selectAudio = json['selectAudio'];
    banAudio = json['banAudio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heroId'] = this.heroId;
    data['name'] = this.name;
    data['alias'] = this.alias;
    data['title'] = this.title;
    data['roles'] = this.roles;
    data['isWeekFree'] = this.isWeekFree;
    data['attack'] = this.attack;
    data['defense'] = this.defense;
    data['magic'] = this.magic;
    data['difficulty'] = this.difficulty;
    data['selectAudio'] = this.selectAudio;
    data['banAudio'] = this.banAudio;
    return data;
  }
}
