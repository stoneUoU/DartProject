enum HttpMethod { GET, POST, DELETE }

///基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  String authority() {
    return "mgapp.appearoo.top";
  }

  String authorityPath() {
    return "/api.php";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (httpMethod() != HttpMethod.POST) {
      //拼接path参数
      if (pathParams != null) {
        if (path().endsWith("/")) {
          pathStr = "${path()}$pathParams";
        } else {
          pathStr = "${path()}/$pathParams";
        }
      }
    }
    //http和https切换
    if (httpMethod() != HttpMethod.POST) {
      if (useHttps) {
        uri = Uri.https(authority(), authorityPath() + pathStr, params);
      } else {
        uri = Uri.http(authority(), authorityPath() + pathStr, params);
      }
    } else {
      if (useHttps) {
        uri = Uri.https(authority(), authorityPath() + pathStr);
      } else {
        uri = Uri.http(authority(), authorityPath() + pathStr);
      }
    }
    return uri.toString();
  }

  bool needLogin();

  Map<String, dynamic> params = {};

  ///添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v;
    return this;
  }

  Map<String, dynamic> header = {"Content-Type": "application/json"};

  ///添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}

// abstract class BaseRequest {
//   var pathParams;
//   var useHttps = true;
//
//   String authority() {
//     return "fuwu.nhsa.gov.cn";
//   }
//
//   String authorityPath() {
//     return "/ebus/fuwu/api";
//   }
//
//   HttpMethod httpMethod();
//
//   String path();
//
//   String url() {
//     Uri uri;
//     var pathStr = path();
//     if (httpMethod() != HttpMethod.POST) {
//       //拼接path参数
//       if (pathParams != null) {
//         if (path().endsWith("/")) {
//           pathStr = "${path()}$pathParams";
//         } else {
//           pathStr = "${path()}/$pathParams";
//         }
//       }
//     }
//     //http和https切换
//     if (httpMethod() != HttpMethod.POST) {
//       if (useHttps) {
//         uri = Uri.https(authority(), authorityPath() + pathStr, params);
//       } else {
//         uri = Uri.http(authority(), authorityPath() + pathStr, params);
//       }
//     } else {
//       if (useHttps) {
//         uri = Uri.https(authority(), authorityPath() + pathStr);
//       } else {
//         uri = Uri.http(authority(), authorityPath() + pathStr);
//       }
//     }
//     return uri.toString();
//   }
//
//   bool needLogin();
//
//   Map<String, dynamic> params = {
//     "signType": "plain",
//     "encType": "plain",
//     "version": "1.3.2",
//     "timestamp": "1599036663",
//     "appId": "19E179E5DC29C05E65B90CDE57A1C7E5"
//   };
//
//   ///添加参数
//   BaseRequest add(String k, Object v) {
//     params[k] = v;
//     return this;
//   }
//
//   Map<String, dynamic> header = {"Content-Type": "application/json"};
//
//   ///添加header
//   BaseRequest addHeader(String k, Object v) {
//     header[k] = v.toString();
//     return this;
//   }
// }
