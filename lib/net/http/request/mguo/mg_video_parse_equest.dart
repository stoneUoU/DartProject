import 'package:DartProject/net/http/request/base_request.dart';

class MGVideoParseRequest extends BaseRequest {
  String requestUrl = "";

  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  String url() {
    // TODO: implement url
    return requestUrl;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "";
  }
}
