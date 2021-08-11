import 'package:dart_demo/base/route/RouteHandles.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static String root = "/";
  static String designView = "/report/reportList";
  static String designDetailView = "/report/reportDetail";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(handlerFunc: (context, params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(designView, handler: reportViewHandler);
    router.define(designDetailView, handler: reportDetailViewHandler);
  }
}
