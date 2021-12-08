/// parser : "zakkpa"
/// player : "dplayer"
/// code : "200"
/// success : "1"
/// metareferer : "origin"
/// type : "hls"
/// user-agent : "Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1"
/// referer : "https://www.mgtv.com/b/348763/11244273.html"
/// url : "https://pcvideoaliyun.titan.mgtv.com/c1/2021/03/12_0/9649C9992BC99FD648FBE573BC7B36F1_20210313_1_1_734_mp4/D59AC88E15115A1C50A8FC7AD7851A78.m3u8?arange=0&pm=hmvqNg2gSX7ngH~xvj1toHGzA8Ki_DvMeJBKddNpWVX2n5IX4hVlfmKxBx_7Byf~Y3UVUeMq0SwKnoRd5MoAKh6m2E2PKcDTOSdxhzSY1rqF~PEjUkUMNqCiHvI_7LYbd_mhwKsd5K9NUXQuFPbge4unEQJQC1RTGarblCoHnDcjCwzXbu~J39VTO2KFe08sU4efftVIB59faiPmA8L_KHarT5X8VR3G_juvjsjK5kRCSafJSiAjFDM~0sUmg7tPA0OhJDtlc2YAfHW6A8Az8nEdVdWNu8suu~7Kk4IUzT1z8FljToZ03iS79GLqoKS1dFELwaspXNpyVazXBBxiUTvga0Gbk8p5G1pJOKGUxztoMfGPRBtO0~ITjTRvBd5KUo1f0T9~_hcrN978g0ZKipYSga~4eyzj2_8f1FfJnDvo7MN~It53YP2dTkpJXrGwNelNXDY2rfVhzpJghJkF22J_it_ZsMIL1jIhe7hEodMMcSUd&mr=HXhYdDBTQRbzOQOJRVtkcJssWcuCHj6ij_~7B76OBaIo9Y0526AYoaEKy3x4~0IlsBIFHo8HGno-&vcdn=0&scid=25021&cpno=6k14ls&ruid=cbf004fb00164a15&ld=sdkbytelog02_sdkbytelog02&_t=1629357220988&parwix"

/// parser : "萌果计费系统"
/// status : 200
/// code : 1
/// cookies : {"__puus":"d9bbd0ce4beb17cf0e8ab60fecffd9ebAASFJKosjNAtXxc6knkmwBTqzelqKJlLZ6PsgoKotdxp5DSd6N1jq5UQR+/X5hOobrgmlKOlDag7sfL+LM8SD3/Ck6fpHA46FG3Rj8aVjxI67CPD9hQDnRx6ONVOyUWJ9TkRk2xecHw9MAmnrxAMsknq"}
/// size : 1589525126
/// message : "ok"
/// name : "熔炉.qsv"
/// url : "https://dl-pc.cdn.yun.cn/5a82b9a126124d04bdc56b5137daa5ff?filename=%E7%86%94%E7%82%89.qsv&auth_key=1638968175-1552270-21600-4180ce5ac46816ff62120ca0c4a81204&sp=378&token=2-c4ee345f43c26e9f0cde3a9a8135eec4-2-1-20480-5a82b9a126124d04bdc56b5137daa5ff-fc7084e4b9c993edbe0e91fc42f8172b"

class MGVideoParseModel {
  MGVideoParseModel({
    String? parser,
    String? status,
    String? code,
    MGVideoCookies? cookies,
    int? size,
    String? message,
    String? name,
    String? url,
  }) {
    _parser = parser;
    _status = status;
    _code = code;
    _cookies = cookies;
    _size = size;
    _message = message;
    _name = name;
    _url = url;
  }

  MGVideoParseModel.fromJson(dynamic json) {
    _parser = json['parser'];
    _status = "${json['status']}";
    _code = "${json['code']}";
    _cookies = json['cookies'] != null
        ? MGVideoCookies.fromJson(json['cookies'])
        : null;
    _size = json['size'];
    _message = json['message'];
    _name = json['name'];
    _url = json['url'];
  }

  String? _parser;
  String? _status;
  String? _code;
  MGVideoCookies? _cookies;
  int? _size;
  String? _message;
  String? _name;
  String? _url;

  String? get parser => _parser;

  String? get status => _status;

  String? get code => _code;

  MGVideoCookies? get cookies => _cookies;

  int? get size => _size;

  String? get message => _message;

  String? get name => _name;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parser'] = _parser;
    map['status'] = _status;
    map['code'] = _code;
    if (_cookies != null) {
      map['cookies'] = _cookies?.toJson();
    }
    map['size'] = _size;
    map['message'] = _message;
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }
}

/// __puus : "d9bbd0ce4beb17cf0e8ab60fecffd9ebAASFJKosjNAtXxc6knkmwBTqzelqKJlLZ6PsgoKotdxp5DSd6N1jq5UQR+/X5hOobrgmlKOlDag7sfL+LM8SD3/Ck6fpHA46FG3Rj8aVjxI67CPD9hQDnRx6ONVOyUWJ9TkRk2xecHw9MAmnrxAMsknq"

class MGVideoCookies {
  MGVideoCookies({
    String? puus,
  }) {
    _puus = puus;
  }

  MGVideoCookies.fromJson(dynamic json) {
    _puus = json['__puus'];
  }

  String? _puus;

  String? get puus => _puus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__puus'] = _puus;
    return map;
  }
}

class MGVideoParseResModel {
  String? _url;
  String? _cookie;
  String? _userAgent;
  String? _videoName;

  String? get url => _url;

  String? get cookie => _cookie;

  String? get userAgent => _userAgent;

  String? get videoName => _videoName;

  setUrl(String url) {
    _url = url;
  }

  setVideoName(String videoName) {
    _videoName = videoName;
  }

  setUserAgent(String userAgent) {
    _userAgent = userAgent;
  }

  setCookie(String cookie) {
    _cookie = cookie;
  }

  MGVideoParseResModel(
      {String? parser, String? cookie, String? userAgent, String? videoName}) {
    _url = url;
    _cookie = cookie;
    _userAgent = userAgent;
    _videoName = videoName;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = _url;
    map["cookie"] = _cookie;
    map["userAgent"] = _userAgent;
    map["videoName"] = _videoName;
    return map;
  }
}
