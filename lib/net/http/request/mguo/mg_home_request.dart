import 'package:FlutterProject/net/http/request/base_request.dart';

class MGHomeRequest extends BaseRequest {
  int pathCategory = 0;

  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    if (pathCategory == 0) {
      return "/provide/home_nav";
    } else if (pathCategory == 1) {
      return "/provide/home_data";
    } else {
      return "/provide/news";
    }
  }
}
