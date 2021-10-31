import 'package:FlutterProject/logic/mguo/home/model/mg_ad_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/mguo/mg_movie_request.dart';

class MGMovieDao {
  static videoInfo(int id) {
    return _sendVideoInfo(id);
  }

  static videoAds(String flag) {
    return _sendVideoAds(flag);
  }

  static videoAddCollect(String flag) {
    return _sendVideoAddCollect(flag);
  }

  static videoCancelCollect(String flag) {
    return _sendVideoCancelCollect(flag);
  }

  static videoCommentList(int movieId, int pageIndex) {
    return _sendVideoCommentList(movieId, pageIndex);
  }

  static _sendVideoInfo(int id) async {
    MGMovieRequest request;
    MGVideoDetailModel model = MGVideoDetailModel();
    request = MGMovieRequest();
    request.pathCategory = 0;
    request.add("id", id);
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

  static _sendVideoAddCollect(String flag) async {
    MGMovieRequest request;
    MGAdModel model = MGAdModel();
    request = MGMovieRequest();
    request.pathCategory = 2;
    request.add("flag", flag);
    var result = await HiNet().fire(request);
    model = MGAdModel.fromJson(result["data"]);
    return model;
  }

  static _sendVideoCancelCollect(String flag) async {
    MGMovieRequest request;
    MGAdModel model = MGAdModel();
    request = MGMovieRequest();
    request.pathCategory = 2;
    request.add("flag", flag);
    var result = await HiNet().fire(request);
    model = MGAdModel.fromJson(result["data"]);
    return model;
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
