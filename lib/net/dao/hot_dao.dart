import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/base_request.dart';
import 'package:FlutterProject/net/http/request/hot_request.dart';

class HotDao {
  static module(String version, String clntType) {
    return _send(version, clntType);
  }

  static _send(String version, String clntType) async {
    BaseRequest request;
    request = HotRequest();
    request.add("data", {"type": version, "clntType": clntType});
    var result = await HiNet().fire(request);
    print(result);
    return result;
  }
}
