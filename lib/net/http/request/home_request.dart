import 'package:DartProject/net/http/request/base_request.dart';

class HomeRequest extends BaseRequest {
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
      return "/base/api/bmgt/appChnlHolder/listAppModule";
    } else {
      return "/base/api/news/topList";
    }
  }
}
