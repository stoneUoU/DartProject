import 'package:DartProject/logic/mguo/home/model/MGAdModel.dart';
import 'package:DartProject/logic/mguo/home/model/MGVideoDetailModel.dart';
import 'package:DartProject/logic/mguo/topics/model/MGAdModels.dart';
import 'package:DartProject/net/http/core/hi_net.dart';
import 'package:DartProject/net/http/request/mguo/mg_movie_request.dart';

class MGMovieDao {
  static videoInfo(int id, String token) {
    return _sendVideoInfo(id, token);
  }

  static videoAds(String flag) {
    return _sendVideoAds(flag);
  }

  static videoAddCollect(int id, String token) {
    return _sendVideoAddCollect(id, token);
  }

  static videoCancelCollect(int id, String token) {
    return _sendVideoCancelCollect(id, token);
  }

  static videoCommentList(int videoId, int pageIndex) {
    return _sendVideoCommentList(videoId, pageIndex);
  }

  static _sendVideoInfo(int id, String token) async {
    MGMovieRequest request;
    MGVideoDetailModel model = MGVideoDetailModel();
    request = MGMovieRequest();
    request.pathCategory = 0;
    request.add("id", id);
    request.add("token", token);
    var result = await HiNet().fire(request);
    model = MGVideoDetailModel.fromJson(result);
    // print("res____${model.toJson()}");
    return model;
  }

  static _sendVideoAds(String flag) async {
    MGMovieRequest request;
    MGAdModels model = MGAdModels();
    request = MGMovieRequest();
    request.pathCategory = 1;
    request.add("flag", flag);
    var result = await HiNet().fire(request);
    print("result____${result}");
    model = MGAdModels.fromJson(result);
    return model;
  }

  static _sendVideoAddCollect(int id, String token) async {
    MGMovieRequest request;
    MGAdModel model = MGAdModel();
    request = MGMovieRequest();
    request.pathCategory = 2;
    request.add("id", id);
    request.add("token", token);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendVideoCancelCollect(int id, String token) async {
    MGMovieRequest request;
    MGAdModel model = MGAdModel();
    request = MGMovieRequest();
    request.pathCategory = 3;
    request.add("ids", id);
    request.add("token", token);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendVideoCommentList(int videoId, int pageIndex) async {
    MGMovieRequest request;
    request = MGMovieRequest();
    request.pathCategory = 4;
    request.add("vod_id", videoId);
    request.add("page", pageIndex);
    request.add("limit", 10);
    var result = await HiNet().fire(request);
    return result;
  }
}
