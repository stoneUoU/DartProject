/// id : 308
/// name : "萌果官方账号"
/// user_portrait : "https://mgapp.appearoo.top/upload/user/9/579.png?9573"
/// ip : "0.0.0.0"
/// time : "14分钟前"
/// content : "真的惊艳到我了，光说那个画质和特效，仿佛身临其境，美轮美奂。打斗场面动作流畅，看得又刺激又爽。还有那个修罗城，现代末日的场景，还有各种穿越来的人、妖、鬼怪来一场绝地求生，牛马和罗刹门的对峙，将光怪陆离的世界展现的淋漓尽致。剧情方面更是没得说，免得剧透，我只能说，我太喜欢小青了，我也喜欢这部里面的小白，太帅了，爱了爱了。喜欢小青，又强又勇，还重情重义，并且姐妹情深，容我磕一下。"
/// up : 0
/// down : 0
/// imgs : ["A","B"]
/// sub : [{"id":311,"name":"萌果官方账号","ip":"0.0.0.0","time":"9分钟前","content":"让无池记得你不愿抹去的执念，让黑风洞记得我经年不改的罢休，让如果桥记得你长出翅膀的甘愿，让修罗城记得我不会超度的因缘。不懂为何最苦最怨是求而不得，直到雷峰塔下几度轮回遇不到她。谁说这执念虚渺一切皆空，愿为修炼这执念一瞬二十年。不在乎记忆全无，面目全非，只想证明遇见你不是劫，是缘。","up":0,"down":0,"user_portrait":"https://mgapp.appearoo.top/upload/user/9/579.png?9573"},{"id":310,"name":"萌果官方账号","ip":"0.0.0.0","time":"9分钟前","content":"要留青白在人间","up":0,"down":0,"user_portrait":"https://mgapp.appearoo.top/upload/user/9/579.png?9573"},{"id":309,"name":"萌果官方账号","ip":"0.0.0.0","time":"9分钟前","content":"次日，小青因涉嫌偷盗文物被杭州市公安局西湖区分局依法刑事拘留。","up":0,"down":0,"user_portrait":"https://mgapp.appearoo.top/upload/user/9/579.png?9573"}]

class MGCommentModel {
  MGCommentModel({
    int? id,
    String? name,
    String? userPortrait,
    String? ip,
    String? time,
    String? content,
    int? up,
    int? down,
    List<String>? imgs,
    List<Sub>? sub,
  }) {
    _id = id;
    _name = name;
    _userPortrait = userPortrait;
    _ip = ip;
    _time = time;
    _content = content;
    _up = up;
    _down = down;
    _imgs = imgs;
    _sub = sub;
  }

  MGCommentModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _userPortrait = json['user_portrait'];
    _ip = json['ip'];
    _time = json['time'];
    _content = json['content'];
    _up = json['up'];
    _down = json['down'];
    _imgs = json['imgs'] != null ? json['imgs'].cast<String>() : [];
    if (json['sub'] != null) {
      _sub = [];
      json['sub'].forEach((v) {
        _sub?.add(Sub.fromJson(v));
      });
    }
  }

  int? _id;
  String? _name;
  String? _userPortrait;
  String? _ip;
  String? _time;
  String? _content;
  int? _up;
  int? _down;
  List<String>? _imgs;
  List<Sub>? _sub;

  int? get id => _id;

  String? get name => _name;

  String? get userPortrait => _userPortrait;

  String? get ip => _ip;

  String? get time => _time;

  String? get content => _content;

  int? get up => _up;

  int? get down => _down;

  List<String>? get imgs => _imgs;

  List<Sub>? get sub => _sub;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['user_portrait'] = _userPortrait;
    map['ip'] = _ip;
    map['time'] = _time;
    map['content'] = _content;
    map['up'] = _up;
    map['down'] = _down;
    map['imgs'] = _imgs;
    if (_sub != null) {
      map['sub'] = _sub?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 311
/// name : "萌果官方账号"
/// ip : "0.0.0.0"
/// time : "9分钟前"
/// content : "让无池记得你不愿抹去的执念，让黑风洞记得我经年不改的罢休，让如果桥记得你长出翅膀的甘愿，让修罗城记得我不会超度的因缘。不懂为何最苦最怨是求而不得，直到雷峰塔下几度轮回遇不到她。谁说这执念虚渺一切皆空，愿为修炼这执念一瞬二十年。不在乎记忆全无，面目全非，只想证明遇见你不是劫，是缘。"
/// up : 0
/// down : 0
/// user_portrait : "https://mgapp.appearoo.top/upload/user/9/579.png?9573"

class Sub {
  Sub({
    int? id,
    String? name,
    String? ip,
    String? time,
    String? content,
    int? up,
    int? down,
    String? userPortrait,
  }) {
    _id = id;
    _name = name;
    _ip = ip;
    _time = time;
    _content = content;
    _up = up;
    _down = down;
    _userPortrait = userPortrait;
  }

  Sub.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _ip = json['ip'];
    _time = json['time'];
    _content = json['content'];
    _up = json['up'];
    _down = json['down'];
    _userPortrait = json['user_portrait'];
  }

  int? _id;
  String? _name;
  String? _ip;
  String? _time;
  String? _content;
  int? _up;
  int? _down;
  String? _userPortrait;

  int? get id => _id;

  String? get name => _name;

  String? get ip => _ip;

  String? get time => _time;

  String? get content => _content;

  int? get up => _up;

  int? get down => _down;

  String? get userPortrait => _userPortrait;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['ip'] = _ip;
    map['time'] = _time;
    map['content'] = _content;
    map['up'] = _up;
    map['down'] = _down;
    map['user_portrait'] = _userPortrait;
    return map;
  }
}
