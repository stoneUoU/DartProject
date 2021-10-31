import 'package:FlutterProject/logic/mguo/home/model/mg_home_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_home_nav_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_home_slide_model.dart';
import 'package:FlutterProject/logic/mguo/home/model/mg_marquee_model.dart';
import 'package:FlutterProject/net/http/core/hi_net.dart';
import 'package:FlutterProject/net/http/request/base_request.dart';
import 'package:FlutterProject/net/http/request/mguo/mg_home_request.dart';

class MGHomeDao {
  static navigator() {
    return _sendNavigator();
  }

  static dataRecommendLists(int id, int page) {
    return _sendDataRecommendLists(id, page);
  }

  static dataMoreColumnLists(int type_id, String order) {
    return _sendDataMoreColumnLists(type_id, order);
  }

  static dataMarquees(int page, int limit) {
    return _sendDataMarquees(page, limit);
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

  static _sendDataRecommendLists(int id, int page) async {
    MGHomeRequest request;
    request = MGHomeRequest();
    request.pathCategory = 1;
    request.add("id", id);
    request.add("page", page);
    var result = await HiNet().fire(request);
    if (id == 0) {
      MGHomeModel model = MGHomeModel();
      model = MGHomeModel.fromJson(result);
      return model;
    } else {
      MGSlideListModel slideListModel = MGSlideListModel.fromJson(result);
      return slideListModel;
    }
  }

  static _sendDataMoreColumnLists(int type_id, String order) async {
    MGHomeRequest request;
    MGHomeModel model = MGHomeModel();
    request = MGHomeRequest();
    request.pathCategory = 2;
    request.add("type_id", type_id);
    request.add("order", order);
    var result = await HiNet().fire(request);
    model = MGHomeModel.fromJson(result["data"]);

    return model;
  }

  static _sendDataMarquees(int page, int limit) async {
    MGHomeRequest request;
    MGMarqueeModel model = MGMarqueeModel();
    request = MGHomeRequest();
    request.pathCategory = 3;
    request.add("page", page);
    request.add("limit", limit);
    var result = await HiNet().fire(request);
    model = MGMarqueeModel.fromJson(result["data"]);
    return model;
  }
}
