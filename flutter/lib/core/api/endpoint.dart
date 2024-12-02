abstract class Endpoints {
  static const String baseUrl = '192.168.146.66:8000';
  static const String login = '/api/signin';
  static const String register = '/api/signup';
  static const String question = '/api/evaluate';
}

abstract class ApiKeys {
  static const String token = "token";
  static const String gender = "gender";
  static const String email = "email";
  static const String password = "password";
  static const String name = "name";
  static const String phoneNumber = "phoneNumber";
  static const String confirmPassword = "confirmPassword";
  static const String data = "data";
}
