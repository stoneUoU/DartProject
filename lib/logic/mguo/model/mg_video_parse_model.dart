/// parser : "zakkpa"
/// player : "dplayer"
/// code : "200"
/// success : "1"
/// metareferer : "origin"
/// type : "hls"
/// user-agent : "Mozilla/5.0 (iPad; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.34 (KHTML, like Gecko) Version/11.0 Mobile/15A5341f Safari/604.1"
/// referer : "https://www.mgtv.com/b/348763/11244273.html"
/// url : "https://pcvideoaliyun.titan.mgtv.com/c1/2021/03/12_0/9649C9992BC99FD648FBE573BC7B36F1_20210313_1_1_734_mp4/D59AC88E15115A1C50A8FC7AD7851A78.m3u8?arange=0&pm=hmvqNg2gSX7ngH~xvj1toHGzA8Ki_DvMeJBKddNpWVX2n5IX4hVlfmKxBx_7Byf~Y3UVUeMq0SwKnoRd5MoAKh6m2E2PKcDTOSdxhzSY1rqF~PEjUkUMNqCiHvI_7LYbd_mhwKsd5K9NUXQuFPbge4unEQJQC1RTGarblCoHnDcjCwzXbu~J39VTO2KFe08sU4efftVIB59faiPmA8L_KHarT5X8VR3G_juvjsjK5kRCSafJSiAjFDM~0sUmg7tPA0OhJDtlc2YAfHW6A8Az8nEdVdWNu8suu~7Kk4IUzT1z8FljToZ03iS79GLqoKS1dFELwaspXNpyVazXBBxiUTvga0Gbk8p5G1pJOKGUxztoMfGPRBtO0~ITjTRvBd5KUo1f0T9~_hcrN978g0ZKipYSga~4eyzj2_8f1FfJnDvo7MN~It53YP2dTkpJXrGwNelNXDY2rfVhzpJghJkF22J_it_ZsMIL1jIhe7hEodMMcSUd&mr=HXhYdDBTQRbzOQOJRVtkcJssWcuCHj6ij_~7B76OBaIo9Y0526AYoaEKy3x4~0IlsBIFHo8HGno-&vcdn=0&scid=25021&cpno=6k14ls&ruid=cbf004fb00164a15&ld=sdkbytelog02_sdkbytelog02&_t=1629357220988&parwix"

class MGVideoParseModel {
  String? _parser;
  String? _player;
  String? _code;
  String? _success;
  String? _metareferer;
  String? _type;
  String? _userAgent;
  String? _referer;
  String? _url;

  String? get parser => _parser;
  String? get player => _player;
  String? get code => _code;
  String? get success => _success;
  String? get metareferer => _metareferer;
  String? get type => _type;
  String? get userAgent => _userAgent;
  String? get referer => _referer;
  String? get url => _url;

  MGVideoParseModel(
      {String? parser,
      String? player,
      String? code,
      String? success,
      String? metareferer,
      String? type,
      String? userAgent,
      String? referer,
      String? url}) {
    _parser = parser;
    _player = player;
    _code = code;
    _success = success;
    _metareferer = metareferer;
    _type = type;
    _userAgent = _userAgent;
    _referer = referer;
    _url = url;
  }

  MGVideoParseModel.fromJson(dynamic json) {
    _parser = json["parser"];
    _player = json["player"];
    _code = json["code"];
    _success = json["success"];
    _metareferer = json["metareferer"];
    _type = json["type"];
    _userAgent = json["user-agent"];
    _referer = json["referer"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["parser"] = _parser;
    map["player"] = _player;
    map["code"] = _code;
    map["success"] = _success;
    map["metareferer"] = _metareferer;
    map["type"] = _type;
    map["user-agent"] = _userAgent;
    map["referer"] = _referer;
    map["url"] = _url;
    return map;
  }
}
