import 'package:dart_demo/logic/mguo/model/mg_video_decode_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_video_detail_model.dart';
import 'package:dart_demo/net/http/core/hi_net.dart';
import 'package:dart_demo/net/http/request/mg_video_request.dart';

class MGHomeVideoDao {
  static videoInfo(int id) {
    return _sendVideoInfo(id);
  }

  static videoDecode(String player_code) {
    return _sendVideoDecode(player_code);
  }

  static _sendVideoInfo(int id) async {
    MGVideoRequest request;
    MGVideoDetailModel model = MGVideoDetailModel();
    request = MGVideoRequest();
    request.pathCategory = 0;
    request.add("id", id);
    var result = await HiNet().fire(request);
    model = MGVideoDetailModel.fromJson(result);
    return model;
  }

  static _sendVideoDecode(String player_code) async {
    MGVideoRequest request;
    MGVideoDecodeModel model = MGVideoDecodeModel();
    request = MGVideoRequest();
    request.pathCategory = 1;
    request.add("player_code", player_code);
    var result = await HiNet().fire(request);
    model = MGVideoDecodeModel.fromJson(result);
    return model;
  }
}
