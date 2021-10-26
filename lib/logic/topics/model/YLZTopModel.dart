/// id : 83
/// title : "电影《灵媒》泰国恐怖片在线观看"
/// img : "//p0.meituan.net/movie/90324ff6234df09b2158ef95b8faa61658359.jpg"

class YLZTopModel {
  YLZTopModel({
      int? id, 
      String? title, 
      String? img,}){
    _id = id;
    _title = title;
    _img = img;
}

  YLZTopModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _img = json['img'];
  }
  int? _id;
  String? _title;
  String? _img;

  int? get id => _id;
  String? get title => _title;
  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['img'] = _img;
    return map;
  }

}