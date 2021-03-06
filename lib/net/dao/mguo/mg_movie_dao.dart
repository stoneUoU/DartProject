import 'package:FlutterProject/logic/mguo/home/model/mg_ad_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/mguo/mg_movie_request.dart';

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

  static videoCommentList(int movieId, int pageIndex) {
    return _sendVideoCommentList(movieId, pageIndex);
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
    MGAdModel model = MGAdModel();
    request = MGMovieRequest();
    request.pathCategory = 1;
    request.add("flag", flag);
    var result = await HiNet().fire(request);
    model = MGAdModel.fromJson(result["data"]);
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

  static _sendVideoCommentList(int movieId, int pageIndex) async {
    MGMovieRequest request;
    request = MGMovieRequest();
    request.pathCategory = 4;
    request.add("vod_id", movieId);
    request.add("page", pageIndex);
    request.add("limit", 10);
    var result = await HiNet().fire(request);
    return result;
  }
}
