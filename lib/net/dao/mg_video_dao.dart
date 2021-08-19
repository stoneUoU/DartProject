import 'package:dart_demo/logic/mguo/model/mg_video_detail_model.dart';
import 'package:dart_demo/net/http/core/hi_net.dart';
import 'package:dart_demo/net/http/request/mg_video_request.dart';

class MGHomeVideoDao {
  static videoInfo(int id) {
    return _sendVideoInfo(id);
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
}
