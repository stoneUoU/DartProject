import 'package:FlutterProject/net/http/request/base_request.dart';

class AreaRequest extends BaseRequest {
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
    return "/base/api/applet/provinces";
  }
}
