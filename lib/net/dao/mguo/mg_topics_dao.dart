import 'package:DartProject/logic/mguo/topics/model/MGDetailModel.dart';
import 'package:DartProject/net/http/core/hi_net.dart';
import 'package:DartProject/net/http/request/base_request.dart';
import 'package:DartProject/net/http/request/mguo/mg_topics_request.dart';

class MGTopicDao {
  static list(int pageIndex) {
    return _sendList(pageIndex);
  }

  static detail(int id) {
    return _sendDetail(id);
  }

  static _sendList(int pageIndex) async {
    BaseRequest request;
    request = MGTopicsRequest();
    request.add("page", pageIndex);
    request.add("limit", 10);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendDetail(int id) async {
    MGTopicsRequest request = MGTopicsRequest();
    request.pathCategory = 1;
    request.add("id", id);
    var result = await HiNet().fire(request);
    MGDetailModel model = MGDetailModel();
    model = MGDetailModel.fromJson(result["info"]);
    return model;
  }
}
