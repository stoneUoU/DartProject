import 'package:dart_demo/net/http/core/hi_net_adapter.dart';
import 'package:dart_demo/net/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNetResponse<T>>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          data: {"code": 0, "message": 'success'} as T,
          request: request,
          statusCode: 403,
          statusMessage: "鉴权失败");
    });
  }
}
