/// id : 243
/// title : "《八角亭谜雾》剧评："
/// readCount : 992
/// add_time : "2021-10-25 14:01"
/// imgs : ["https://www.xigtv.com/upload/art/2021/10/h4g343t02wd.jpg","https://www.xigtv.com/upload/art/2021/10/q22nihd50kt.jpg"]

class MGListModel {
  MGListModel({
    int? id,
    String? title,
    String? desc,
    int? readCount,
    String? addTime,
    List<String>? imgs,
  }) {
    _id = id;
    _title = title;
    _desc = desc;
    _readCount = readCount;
    _addTime = addTime;
    _imgs = imgs;
  }

  MGListModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _desc = json['desc'];
    _readCount = json['readCount'];
    _addTime = json['add_time'];
    _imgs = json['imgs'] != null ? json['imgs'].cast<String>() : [];
  }

  int? _id;
  String? _title;
  String? _desc;
  int? _readCount;
  String? _addTime;
  List<String>? _imgs;

  int? get id => _id;

  String? get title => _title;

  String? get desc => _desc;

  int? get readCount => _readCount;

  String? get addTime => _addTime;

  List<String>? get imgs => _imgs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['desc'] = _desc;
    map['readCount'] = _readCount;
    map['add_time'] = _addTime;
    map['imgs'] = _imgs;
    return map;
  }
}
