import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:integrate_service/screens/login_screen.dart';

class DBHelper {
  final FlutterSecureStorage flutterSecureStorage =
      const FlutterSecureStorage();
  String token = "Token";
  String noToken = "noToken";

  void write(String value) {
    flutterSecureStorage.write(key: token, value: value);
  }

  Future<String> readToken() async {
    String? tokenUser = await flutterSecureStorage.read(key: token.toString());
    return tokenUser ?? noToken;
  }

  void deleteAll() {
    flutterSecureStorage.deleteAll();
  }
}
