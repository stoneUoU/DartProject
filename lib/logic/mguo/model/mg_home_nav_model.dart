/// id : 0
/// msg : []
/// name : "推荐"

class MGHomeNavModel {
  String? _name;
  int? _id;
  List<Msg>? _msg;

  String? get name => _name;
  int? get id => _id;
  List<Msg>? get msg => _msg;

  MGHomeNavModel({String? name, int? id, List<Msg>? msg}) {
    _name = name;
    _id = id;
    _msg = msg;
  }

  MGHomeNavModel.fromJson(dynamic json) {
    _name = json["name"];
    _id = json["id"];
    if (json["msg"] != null) {
      _msg = [];
      json["msg"].forEach((v) {
        _msg?.add(Msg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["id"] = _id;
    if (_msg != null) {
      map["msg"] = _msg?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "class"
/// data : ["类型","搞笑"]

class Msg {
  String? _name;
  List<String>? _data;

  String? get name => _name;
  List<String>? get data => _data;

  Msg({String? name, List<String>? data}) {
    _name = name;
    _data = data;
  }

  Msg.fromJson(dynamic json) {
    _name = json["name"];
    _data = json["data"] != null ? json["data"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["data"] = _data;
    return map;
  }
}
