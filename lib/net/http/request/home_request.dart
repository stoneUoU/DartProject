import 'package:dart_demo/net/http/request/base_request.dart';

class HomeRequest extends BaseRequest {
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
      return "/base/api/bmgt/appChnlHolder/listAppModule";
    } else {
      return "/base/api/news/topList";
    }
  }
}
