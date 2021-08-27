import 'package:dart_demo/logic/mguo/model/mg_home_model.dart';
import 'package:dart_demo/logic/mguo/model/mg_home_nav_model.dart';
import 'package:dart_demo/net/http/core/hi_net.dart';
import 'package:dart_demo/net/http/request/base_request.dart';
import 'package:dart_demo/net/http/request/mg_home_request.dart';

class MGHomeDao {
  static navigator() {
    return _sendNavigator();
  }

  static dataLists(int id) {
    return _sendDataLists(id);
  }

  static _sendNavigator() async {
    BaseRequest request;
    List<MGHomeNavModel> list = [];
    request = MGHomeRequest();
    var result = await HiNet().fire(request);
    for (int index = 0; index < result.length; index++) {
      MGHomeNavModel model = MGHomeNavModel.fromJson(result[index]);
      list.add(model);
    }
    return list;
  }

  static _sendDataLists(int id) async {
    MGHomeRequest request;
    MGHomeModel model = MGHomeModel();
    request = MGHomeRequest();
    request.pathCategory = 1;
    request.add("id", id);
    var result = await HiNet().fire(request);
    model = MGHomeModel.fromJson(result);
    return model;
  }
}
