/// user_id : 523
/// user_name : "15717914505"
/// user_nick_name : "龙湖春江天玺-北京"
/// token : "e3a454e79d082a42ae27aafef238b3a1"

class MGLoginModel {
  MGLoginModel({
    int? userId,
    String? userName,
    String? userNickName,
    String? token,
  }) {
    _userId = userId;
    _userName = userName;
    _userNickName = userNickName;
    _token = token;
  }

  MGLoginModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userName = json['user_name'];
    _userNickName = json['user_nick_name'];
    _token = json['token'];
  }

  int? _userId;
  String? _userName;
  String? _userNickName;
  String? _token;

  int? get userId => _userId;

  String? get userName => _userName;

  String? get userNickName => _userNickName;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['user_nick_name'] = _userNickName;
    map['token'] = _token;
    return map;
  }
}
