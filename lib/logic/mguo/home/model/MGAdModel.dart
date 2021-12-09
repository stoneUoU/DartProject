/// title : "双十一"
/// img : "http://ykimg.alicdn.com/develop/image/2020-08-20/a7f6b424f42b8bd53b824c257433e5ab.png"
/// url : "https://mguo.lanzoux.com/ibOZRiyxkqb"
/// subTitle : ""

class MGAdModel {
  String? _title;
  String? _img;
  String? _url;
  String? _subTitle;

  String? get title => _title;
  String? get img => _img;
  String? get url => _url;
  String? get subTitle => _subTitle;

  MGAdModel({String? title, String? img, String? url, String? subTitle}) {
    _title = title;
    _img = img;
    _url = url;
    _subTitle = subTitle;
  }

  MGAdModel.fromJson(dynamic json) {
    _title = json["title"];
    _img = json["img"];
    _url = json["url"];
    _subTitle = json["subTitle"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["img"] = _img;
    map["url"] = _url;
    map["subTitle"] = _subTitle;
    return map;
  }
}
