/// msg : "成功"
/// data : "c5PL1xZ80sNVsyKj+Xt5vGY3EHJTyM1JZN5XPl55vyeWBV+po6mFIxpxoNAIhwCNugAktJAUUVb4Voim9P572YMzmm8sFnHs8CRw8eJCJeaqno6sVdJsCL11X3dSUhlGFxNujdI26Uada121GdWs1cBMXzzTXiU0KzDL4g63G8A="
/// code : 1

class MGVideoDecodeModel {
  String? _msg;
  String? _data;
  int? _code;

  String? get msg => _msg;
  String? get data => _data;
  int? get code => _code;

  MGVideoDecodeModel({String? msg, String? data, int? code}) {
    _msg = msg;
    _data = data;
    _code = code;
  }

  MGVideoDecodeModel.fromJson(dynamic json) {
    _msg = json["msg"];
    _data = json["data"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["msg"] = _msg;
    map["data"] = _data;
    map["code"] = _code;
    return map;
  }
}
