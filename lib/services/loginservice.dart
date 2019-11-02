import 'dart:async';
import 'dart:math';

class LoginService {
  Future<bool> login(int loginCode) {
    throw UnimplementedError("Login service not yet implemented");
  }

  Future<dynamic> logout() async {
    throw UnimplementedError("Login service not yet implemented");
  }
}

class MockLoginService implements LoginService {
  Random rand = Random.secure();

  @override
  Future<bool> login(int loginCode) async {
    return Future.delayed(
        Duration(milliseconds: (rand.nextDouble() * 500).truncate()),
        () => loginCode == 666);
  }

  @override
  Future<dynamic> logout() async {
    return Future.delayed(const Duration(seconds: 1), () {});
  }
}

LoginService getLoginService() {
  return MockLoginService();
}
