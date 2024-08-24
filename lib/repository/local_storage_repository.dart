import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  void setToken(String token) async {
    print('Setting token');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', token);
    print('Set token $token');
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    return token;
  }
}
