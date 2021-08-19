import 'package:dart_demo/net/http/request/base_request.dart';

class MGVideoRequest extends BaseRequest {
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
      return "/provide/vod_detail";
    } else {
      return "/provide/home_data";
    }
  }
}
