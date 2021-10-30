import 'package:FlutterProject/net/http/request/base_request.dart';

class MGTopicsRequest extends BaseRequest {
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
      return "/provide/news";
    } else {
      return "/provide/new_detail";
    }
  }
}
