/// id : 126
/// title : "故弄玄虚的傻X电影"
/// readCount : 611
/// content : "</p>“都探索星辰大海了，还玩帝制那一套，我吐了    连大刘的短篇小说的格局都不到。”                                                                                                                                      "
/// add_time : "2021-10-19 21:01"

class YLZDetailModel {
  YLZDetailModel({
    int? id,
    String? title,
    int? readCount,
    String? content,
    String? addTime,
  }) {
    _id = id;
    _title = title;
    _readCount = readCount;
    _content = content;
    _addTime = addTime;
  }

  YLZDetailModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _readCount = json['readCount'];
    _content = json['content'];
    _addTime = json['add_time'];
  }
  int? _id;
  String? _title;
  int? _readCount;
  String? _content;
  String? _addTime;

  int? get id => _id;
  String? get title => _title;
  int? get readCount => _readCount;
  String? get content => _content;
  String? get addTime => _addTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['readCount'] = _readCount;
    map['content'] = _content;
    map['add_time'] = _addTime;
    return map;
  }
}
