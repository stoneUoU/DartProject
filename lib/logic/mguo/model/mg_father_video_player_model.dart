import 'package:dart_demo/logic/mguo/model/mg_video_player_model.dart';

/// videoModel : [{"playerUrl":"https://ks-xpc4.xpccdn.com/26ad2412-3068-43f8-9afc-19de6f94ccde.mp4","img":"http://r1.ykimg.com/053500006004EB8D13EA35084A250A9B?x-oss-process=image/resize,w_750/interlace,1/quality,Q_100/sharpen,100","sectionName":"第1集","videoId":"42068","show":"萌果TV","videoName":"为理想，去实现","isMovie":false,"from":"mguotv"}]
/// show : "萌果TV"
/// icon : ""
/// from : "mguotv"

class MGFatherVideoPlayerModel {
  List<MGVideoPlayerModel>? _videoModel;
  String? _show;
  String? _icon;
  String? _from;

  List<MGVideoPlayerModel>? get videoModel => _videoModel;
  String? get show => _show;
  String? get icon => _icon;
  String? get from => _from;

  MGFatherVideoPlayerModel(
      {List<MGVideoPlayerModel>? videoModel,
      String? show,
      String? icon,
      String? from}) {
    _videoModel = videoModel;
    _show = show;
    _icon = icon;
    _from = from;
  }

  MGFatherVideoPlayerModel.fromJson(dynamic json) {
    if (json["videoModel"] != null) {
      _videoModel = [];
      json["videoModel"].forEach((v) {
        _videoModel?.add(MGVideoPlayerModel.fromJson(v));
      });
    }
    _show = json["show"];
    _icon = json["icon"];
    _from = json["from"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_videoModel != null) {
      map["videoModel"] = _videoModel?.map((v) => v.toJson()).toList();
    }
    map["show"] = _show;
    map["icon"] = _icon;
    map["from"] = _from;
    return map;
  }
}
