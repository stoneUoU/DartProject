import 'package:FlutterProject/logic/mguo/home/model/mg_video_decode_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_parse_model.dart';
import 'package:FlutterProject/logic/mguo/topics/model/MGAdModels.dart';
import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/mguo/mg_video_parse_equest.dart';
import 'package:FlutterProject/net/http/request/mguo/mg_video_request.dart';

class MGHomeVideoDao {
  static videoInfo(int id) {
    return _sendVideoInfo(id);
  }

  static videoDecode(String player_code) {
    return _sendVideoDecode(player_code);
  }

  static videoParse(String requestUrl, String AUTHORIZE) {
    return _sendVideoParse(requestUrl, AUTHORIZE);
  }

  static videoAds(String flag) {
    return _sendVideoAds(flag);
  }

  static _sendVideoInfo(int id) async {
    MGVideoRequest request;
    MGVideoDetailModel model = MGVideoDetailModel();
    request = MGVideoRequest();
    request.pathCategory = 0;
    request.add("id", id);
    var result = await HiNet().fire(request);
    model = MGVideoDetailModel.fromJson(result);
    // print("VideoInfo______${result}");
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

  static _sendVideoAds(String flag) async {
    MGVideoRequest request;
    MGAdModels model = MGAdModels();
    request = MGVideoRequest();
    request.pathCategory = 2;
    request.add("flag", flag);
    var result = await HiNet().fire(request);
    model = MGAdModels.fromJson(result);
    return model;
  }

  static _sendVideoParse(String requestUrl, String AUTHORIZE) async {
    MGVideoParseRequest request;
    MGVideoParseModel parseModel = MGVideoParseModel();
    request = MGVideoParseRequest();
    request.requestUrl = requestUrl;
    request.addHeader("AUTHORIZE", AUTHORIZE);
    var result = await HiNet().fire(request);
    print("result_____${result}");
    parseModel = MGVideoParseModel.fromJson(result);
    return parseModel;
  }
}
