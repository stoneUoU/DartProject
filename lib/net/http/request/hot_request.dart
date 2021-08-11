import 'package:dart_demo/net/http/request/base_request.dart';

class HotRequest extends BaseRequest {
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
    return "/base/api/bmgt/hotWord/getAppHotWordList";
  }
}
