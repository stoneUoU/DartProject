import 'package:DartProject/net/http/core/hi_net.dart';
import 'package:DartProject/net/http/request/base_request.dart';
import 'package:DartProject/net/http/request/mguo/mg_login_request.dart';

class MGLoginDao {
  static login(String user_name, String user_pwd) {
    return _sendLogin(user_name, user_pwd);
  }

  static register(
      String user_name, String user_pwd, String code, String invite_code) {
    return _sendRegister(user_name, user_pwd, code, invite_code);
  }

  static registerSmsCode(String user_name) {
    return _sendRegisterSmsCode(user_name);
  }

  static forgetPwd(String user_name, String user_pwd, String code) {
    return _sendForgetPwd(user_name, user_pwd, code);
  }

  static forgetPwdSmsCode(String user_name) {
    return _sendForgetPwdSmsCode(user_name);
  }

  static _sendLogin(String user_name, String user_pwd) async {
    BaseRequest request;
    request = MGLoginRequest();
    request.add("user_name", user_name);
    request.add("user_pwd", user_pwd);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendRegister(String user_name, String user_pwd, String code,
      String invite_code) async {
    MGLoginRequest request;
    request = MGLoginRequest();
    request.pathCategory = 1;
    request.add("user_name", user_name);
    request.add("user_pwd", user_pwd);
    request.add("code", code);
    request.add("invite_code", invite_code);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendRegisterSmsCode(String user_name) async {
    MGLoginRequest request;
    request = MGLoginRequest();
    request.pathCategory = 2;
    request.add("user_name", user_name);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendForgetPwdSmsCode(String user_name) async {
    MGLoginRequest request;
    request = MGLoginRequest();
    request.pathCategory = 3;
    request.add("user_name", user_name);
    var result = await HiNet().fire(request);
    return result;
  }

  static _sendForgetPwd(String user_name, String user_pwd, String code) async {
    MGLoginRequest request;
    request = MGLoginRequest();
    request.pathCategory = 4;
    request.add("user_name", user_name);
    request.add("user_pwd", user_pwd);
    request.add("code", code);
    var result = await HiNet().fire(request);
    return result;
  }
}
