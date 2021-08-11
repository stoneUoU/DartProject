/// UpdateCount : 13
/// rs : [{"type":2,"bigImg":"http://tu.chdesign.cn//Thumbnail/upload/case/0/ge3tanjtgiytkmjqha2tknronjygox3qojxxa33soruw63s7gy4ta6bwheya.jpg","listImg":null,"title":"C星球家族ip形象","isAccessible":false,"content":null,"city":null,"priceUnit":null,"headImage":null,"sex":false,"hits":null,"userName":null,"mostFields":null,"cateName":null,"dataID":1205508,"imgHeight":955,"imgWidth":1273,"url":null,"time":null,"Budget":0,"isSign":false},{"type":3,"bigImg":null,"listImg":["http://tu.chdesign.cn//Thumbnail/upload/case/0/gezdaojwgm2tkmjzga4dslskkbdv6mrrg54dcnrsa.jpg","http://tu.chdesign.cn//Thumbnail/upload/case/0/gezdanzrha3tanztgezdqlskkbdv6mrrg54dcnrsa.jpg","http://tu.chdesign.cn//Thumbnail/upload/case/0/gezdamjrg43tanzxga4delskkbdv6mrrg54dcnrsa.jpg"],"title":null,"isAccessible":false,"content":null,"city":"广东 潮州","priceUnit":"300元/款","headImage":"http://tu.chdesign.cn//upload/avatars/206640/63650458f2da4a4da20e484aafd266ca.png?x-oss-process=image/resize,m_fill,h_120,w_120,limit_0/format,jpg","sex":false,"hits":null,"userName":"particle","mostFields":"美工设计/花纸设计/平面设计","cateName":null,"dataID":206640,"imgHeight":0,"imgWidth":0,"url":null,"time":null,"Budget":0,"isSign":false}]

class YLZRainBowModel {
  int? _updateCount;
  List<Rs>? _rs;

  int? get updateCount => _updateCount;
  List<Rs>? get rs => _rs;

  YLZRainBowModel({int? updateCount, List<Rs>? rs}) {
    _updateCount = updateCount;
    _rs = rs;
  }

  YLZRainBowModel.fromJson(dynamic json) {
    _updateCount = json["UpdateCount"];
    if (json["rs"] != null) {
      _rs = [];
      json["rs"].forEach((v) {
        _rs?.add(Rs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["UpdateCount"] = _updateCount;
    if (_rs != null) {
      map["rs"] = _rs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : 2
/// bigImg : "http://tu.chdesign.cn//Thumbnail/upload/case/0/ge3tanjtgiytkmjqha2tknronjygox3qojxxa33soruw63s7gy4ta6bwheya.jpg"
/// listImg : null
/// title : "C星球家族ip形象"
/// isAccessible : false
/// content : null
/// city : null
/// priceUnit : null
/// headImage : null
/// sex : false
/// hits : null
/// userName : null
/// mostFields : null
/// cateName : null
/// dataID : 1205508
/// imgHeight : 955
/// imgWidth : 1273
/// url : null
/// time : null
/// Budget : 0
/// isSign : false

class Rs {
  int? _type;
  String? _bigImg;
  dynamic? _listImg;
  String? _title;
  bool? _isAccessible;
  dynamic? _content;
  dynamic? _city;
  dynamic? _priceUnit;
  dynamic? _headImage;
  bool? _sex;
  dynamic? _hits;
  dynamic? _userName;
  dynamic? _mostFields;
  dynamic? _cateName;
  int? _dataID;
  int? _imgHeight;
  int? _imgWidth;
  dynamic? _url;
  dynamic? _time;
  int? _budget;
  bool? _isSign;

  int? get type => _type;
  String? get bigImg => _bigImg;
  dynamic? get listImg => _listImg;
  String? get title => _title;
  bool? get isAccessible => _isAccessible;
  dynamic? get content => _content;
  dynamic? get city => _city;
  dynamic? get priceUnit => _priceUnit;
  dynamic? get headImage => _headImage;
  bool? get sex => _sex;
  dynamic? get hits => _hits;
  dynamic? get userName => _userName;
  dynamic? get mostFields => _mostFields;
  dynamic? get cateName => _cateName;
  int? get dataID => _dataID;
  int? get imgHeight => _imgHeight;
  int? get imgWidth => _imgWidth;
  dynamic? get url => _url;
  dynamic? get time => _time;
  int? get budget => _budget;
  bool? get isSign => _isSign;

  Rs(
      {int? type,
      String? bigImg,
      dynamic? listImg,
      String? title,
      bool? isAccessible,
      dynamic? content,
      dynamic? city,
      dynamic? priceUnit,
      dynamic? headImage,
      bool? sex,
      dynamic? hits,
      dynamic? userName,
      dynamic? mostFields,
      dynamic? cateName,
      int? dataID,
      int? imgHeight,
      int? imgWidth,
      dynamic? url,
      dynamic? time,
      int? budget,
      bool? isSign}) {
    _type = type;
    _bigImg = bigImg;
    _listImg = listImg;
    _title = title;
    _isAccessible = isAccessible;
    _content = content;
    _city = city;
    _priceUnit = priceUnit;
    _headImage = headImage;
    _sex = sex;
    _hits = hits;
    _userName = userName;
    _mostFields = mostFields;
    _cateName = cateName;
    _dataID = dataID;
    _imgHeight = imgHeight;
    _imgWidth = imgWidth;
    _url = url;
    _time = time;
    _budget = budget;
    _isSign = isSign;
  }

  Rs.fromJson(dynamic json) {
    _type = json["type"];
    _bigImg = json["bigImg"];
    _listImg = json["listImg"];
    _title = json["title"];
    _isAccessible = json["isAccessible"];
    _content = json["content"];
    _city = json["city"];
    _priceUnit = json["priceUnit"];
    _headImage = json["headImage"];
    _sex = json["sex"];
    _hits = json["hits"];
    _userName = json["userName"];
    _mostFields = json["mostFields"];
    _cateName = json["cateName"];
    _dataID = json["dataID"];
    _imgHeight = json["imgHeight"];
    _imgWidth = json["imgWidth"];
    _url = json["url"];
    _time = json["time"];
    _budget = json["Budget"];
    _isSign = json["isSign"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["bigImg"] = _bigImg;
    map["listImg"] = _listImg;
    map["title"] = _title;
    map["isAccessible"] = _isAccessible;
    map["content"] = _content;
    map["city"] = _city;
    map["priceUnit"] = _priceUnit;
    map["headImage"] = _headImage;
    map["sex"] = _sex;
    map["hits"] = _hits;
    map["userName"] = _userName;
    map["mostFields"] = _mostFields;
    map["cateName"] = _cateName;
    map["dataID"] = _dataID;
    map["imgHeight"] = _imgHeight;
    map["imgWidth"] = _imgWidth;
    map["url"] = _url;
    map["time"] = _time;
    map["Budget"] = _budget;
    map["isSign"] = _isSign;
    return map;
  }
}
