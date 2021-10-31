/// playerUrl : "http://www.mgtv.com/b/318052/4121873.html"
/// img : "https://p.ssl.qhimg.com/t01de4c315357c9190d.jpg"
/// sectionName : "第32集"
/// videoId : "42484"
/// show : "芒果tv"
/// videoName : "春天里"
/// isMovie : false
/// from : "mgtv"

class MGVideoPlayerModel {
  String? _playerUrl;
  String? _img;
  String? _sectionName;
  int? _videoId;
  String? _show;
  String? _videoName;
  bool? _isMovie;
  String? _from;
  bool? _selected;

  String? get playerUrl => _playerUrl;
  String? get img => _img;
  String? get sectionName => _sectionName;
  int? get videoId => _videoId;
  String? get show => _show;
  String? get videoName => _videoName;
  bool? get isMovie => _isMovie;
  String? get from => _from;
  bool? get selected => _selected;

  //开放给外面设置:
  void setSelected(bool selected) {
    _selected = selected;
  }

  MGVideoPlayerModel(
      {String? playerUrl,
      String? img,
      String? sectionName,
      int? videoId,
      String? show,
      String? videoName,
      bool? checked,
      bool? isMovie,
      String? from,
      bool? selected}) {
    _playerUrl = playerUrl;
    _img = img;
    _sectionName = sectionName;
    _videoId = videoId;
    _show = show;
    _videoName = videoName;
    _isMovie = isMovie;
    _from = from;
    _selected = selected;
  }

  MGVideoPlayerModel.fromJson(dynamic json) {
    _playerUrl = json["playerUrl"];
    _img = json["img"];
    _sectionName = json["sectionName"];
    _videoId = json["videoId"];
    _show = json["show"];
    _videoName = json["videoName"];
    _isMovie = json["isMovie"];
    _from = json["from"];
    _selected = json["selected"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["playerUrl"] = _playerUrl;
    map["img"] = _img;
    map["sectionName"] = _sectionName;
    map["videoId"] = _videoId;
    map["show"] = _show;
    map["videoName"] = _videoName;
    map["isMovie"] = _isMovie;
    map["from"] = _from;
    map["selected"] = _selected;
    return map;
  }
}
