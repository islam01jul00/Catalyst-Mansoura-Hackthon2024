import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gdg_app/core/api/endpoint.dart';

class CachedSecure {
  static late FlutterSecureStorage _storage;
  CachedSecure._();
  static init() {
    _storage = const FlutterSecureStorage();
  }

  static Future<void> saveToken(String value) async {
    return await _storage.write(key: ApiKeys.token, value: value);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: ApiKeys.token);
  }

  static Future<bool> containToken() async {
    return await _storage.containsKey(key: ApiKeys.token);
  }

  static Future<void> deleteToken() async {
    return await _storage.delete(key: ApiKeys.token);
  }

  // static Future<void> saveUserInfo() async {
  //   // User user = User(age: , name: );
  //   Map userMap = user.toJson();
  //   String userString = jsonEncode(userMap);
  //   return await _storage.write(key: 'userInfo', value: userString);
  // }

  // static Future<User?> getUserInfo() async {
  //   String? userInfo = await _storage.read(key: 'userInfo');
  //   if (userInfo != null) {
  //     Map<String, dynamic> userMap = jsonDecode(userInfo);
  //     User user = User.fromJson(userMap);
  //     return user;
  //   }
  //   return null;
  // }
}
