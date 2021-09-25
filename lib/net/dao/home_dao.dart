import 'package:FlutterProject/logic/home/model/YLZDynamicModel.dart';
import 'package:FlutterProject/logic/home/model/YLZModuleModel.dart';
import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/base_request.dart';
import 'package:FlutterProject/net/http/request/home_request.dart';

class HomeDao {
  static module(String version, int clntType) {
    return _sendModule(version, clntType);
  }

  static _sendModule(String version, int clntType) async {
    BaseRequest request;
    request = HomeRequest();
    request.add("data", {"ver": version, "clntType": clntType});
    var result = await HiNet().fire(request);
    YLZModuleModel model = YLZModuleModel.fromJson(result["data"]);
    return model;
  }

  static dynamicNews() {
    return _sendDynamicNews();
  }

  static _sendDynamicNews() async {
    HomeRequest request;
    request = HomeRequest();
    request.pathCategory = 1;
    request.add("data", {});
    var result = await HiNet().fire(request);
    YLZDynamicModel model = YLZDynamicModel.fromJson(result["data"]);
    return model;
  }
}
