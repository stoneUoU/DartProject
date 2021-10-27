import 'package:FlutterProject/logic/area/model/YLZAreaModel.dart';
import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/area_request.dart';
import 'package:FlutterProject/net/http/request/base_request.dart';

class AreaDao {
  static module() {
    return _sendArea();
  }

  static _sendArea() async {
    BaseRequest request;
    request = AreaRequest();
    request.add("data", {"ver": "1.3.4", "clntType": 2});
    var result = await HiNet().fire(request);
    YLZAreaModel model = YLZAreaModel.fromJson(result["data"]);
    return model;
  }
}
