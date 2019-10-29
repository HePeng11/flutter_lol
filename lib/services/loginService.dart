import 'dart:async' show Future;

class LoginService {
  // 是否登录
  static Future<bool> checkLogin() async {
    return Future.delayed(Duration(seconds: 1), () {
      return false;
    });
  }
}
