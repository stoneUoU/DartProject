class MGSlideListModel {
  List<MGSlideModel>? _slide;

  List<MGSlideModel>? get slide => _slide;

  MGSlideListModel({List<MGSlideModel>? slide}) {
    _slide = slide;
  }

  MGSlideListModel.fromJson(dynamic json) {
    if (json["slide"] != null) {
      _slide = [];
      json["slide"].forEach((v) {
        _slide?.add(MGSlideModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_slide != null) {
      map["slide"] = _slide?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 42227
/// url : 42227
/// name : "【混剪】一秒钟太短，不够"
/// img : "https://liangcang-material.alicdn.com/prod/upload/ba887d3fa7874851be7e1e141481c472.jpg?x-oss-process=image/resize,w_2074/interlace,1/quality,Q_80/sharpen,100"
/// type : 1
/// jumpurl : ""

class MGSlideModel {
  int? _id;
  int? _url;
  String? _name;
  String? _img;
  int? _type;
  String? _jumpurl;

  int? get id => _id;

  int? get url => _url;

  String? get name => _name;

  String? get img => _img;

  int? get type => _type;

  String? get jumpurl => _jumpurl;

  MGSlideModel(
      {int? id,
      int? url,
      String? name,
      String? img,
      int? type,
      String? jumpurl}) {
    _id = id;
    _url = url;
    _name = name;
    _img = img;
    _type = type;
    _jumpurl = jumpurl;
  }

  MGSlideModel.fromJson(dynamic json) {
    _id = json["id"];
    _url = json["url"];
    _name = json["name"];
    _img = json["img"];
    _type = json["type"];
    _jumpurl = json["jumpurl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["url"] = _url;
    map["name"] = _name;
    map["img"] = _img;
    map["type"] = _type;
    map["jumpurl"] = _jumpurl;
    return map;
  }
}
