import 'package:FlutterProject/net/http/request/base_request.dart';

class MGMovieRequest extends BaseRequest {
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
      return "/provide/vod_detail"; //详情
    } else if (pathCategory == 1) {
      return "/provide/advert"; //广告
    } else if (pathCategory == 2) {
      return "/provide/collect_add"; //加入收藏
    } else if (pathCategory == 3) {
      return "/provide/collect_delete"; //取消收藏
    } else {
      return "/provide/comments"; //评论列表
    }
  }
}
