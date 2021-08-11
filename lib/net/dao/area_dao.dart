import 'package:dart_demo/logic/area/model/YLZAreaModel.dart';
import 'package:dart_demo/net/http/core/hi_net.dart';
import 'package:dart_demo/net/http/request/area_request.dart';
import 'package:dart_demo/net/http/request/base_request.dart';

class AreaDao {
  static module() {
    return _sendArea();
  }

  static _sendArea() async {
    BaseRequest request;
    request = AreaRequest();
    request.add("data", {});
    var result = await HiNet().fire(request);
    YLZAreaModel model = YLZAreaModel.fromJson(result["data"]);
    return model;
  }
}
