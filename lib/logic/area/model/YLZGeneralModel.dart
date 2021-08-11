/// title : "AAA"
/// indexTag : 10

class YLZGeneralModel {
  String? _title;
  int? _indexTag;
  String? _picUrl;

  String? get title => _title;
  int? get indexTag => _indexTag;
  String? get picUrl => _picUrl;

  YLZGeneralModel({String? title, int? indexTag, String? picUrl}) {
    _title = title;
    _indexTag = indexTag;
    _picUrl = picUrl;
  }

  YLZGeneralModel.fromJson(dynamic json) {
    _title = json["title"];
    _indexTag = json["indexTag"];
    _picUrl = json["picUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["indexTag"] = _indexTag;
    map["picUrl"] = _picUrl;
    return map;
  }
}
