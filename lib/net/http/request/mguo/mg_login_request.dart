import 'package:FlutterProject/net/http/request/base_request.dart';

class MGLoginRequest extends BaseRequest {
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
      return "/provide/login";
    } else if (pathCategory == 1) {
      return "/provide/reg";
    } else if (pathCategory == 2) {
      return "/provide/regcode";
    } else if (pathCategory == 3) {
      //获取重置密码验证码:
      return "/provide/setpass_code";
    } else {
      return "/provide/editpwd";
    }
  }
}
