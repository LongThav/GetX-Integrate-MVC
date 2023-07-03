import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:integrate_service/constant/loading_status.dart';
import 'package:integrate_service/constant/url_base.dart';
import 'package:integrate_service/dashboard_screen.dart';
import 'package:integrate_service/db_helper/cache_token.dart';
import 'package:integrate_service/models/login_model.dart';
import 'package:integrate_service/models/user_random_model.dart';
import 'package:integrate_service/screens/login_screen.dart';

import '../models/profile_model.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool> registerCtrl(String name, String email, String password) async {
    try {
      String url = mainUrl + register;
      final Map<String, dynamic> map = {
        'name': name,
        'email': email,
        'password': password
      };
      debugPrint("Map: $map");
      // name: user,
      // email: user@gmail.com
      // password: user@123
      http.Response response = await http.post(Uri.parse(url), body: map);
      debugPrint("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        isLoading.value = true;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (err) {
      debugPrint("Error: $err");
      isLoading.value = false;
      return false;
    } finally {
      notifyChildrens();
    }
  }

  Rx<LoginModel> loginModel = LoginModel(data: Data(user: User())).obs;
  final DBHelper _dbHelper = DBHelper();

  Future<bool> loginCtrl(String email, String password) async {
    try {
      String url = mainUrl + login;
      final Map<String, dynamic> map = {
        'email': email,
        'password': password,
      };
      http.Response response = await http.post(Uri.parse(url), body: map);
      debugPrint("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        loginModel.value = await compute(parJsonLogin, response.body);
        _dbHelper.write(loginModel.value.data.accessToken);
        if (loginModel.value.data.user.email == email) {
          isLoading.value = true;
          Future.delayed(const Duration(milliseconds: 600), () {
            Get.to(() => const DashBoardScreen());
          });
        } else {
          Get.snackbar('Login again', '');
          isLoading.value = false;
        }
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (err) {
      debugPrint("Error: $err");
      return false;
    } finally {
      notifyChildrens();
    }
  }

  Future<bool> logoutCtrl() async {
    try {
      var token = await _dbHelper.readToken();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      String url = mainUrl + logout;
      http.Response response = await http.post(Uri.parse(url), headers: header);
      debugPrint("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        _dbHelper.deleteAll();
        Future.delayed(const Duration(milliseconds: 600), () {
          Get.off(() => const LoginScreen());
        });
        return true;
      } else {
        return false;
      }
    } catch (err) {
      debugPrint("Error: $err");
      return false;
    } finally {
      notifyChildrens();
    }
  }

  Rx<RandomInfoModel> randomUer = RandomInfoModel(info: Info()).obs;
  Rx<LoadingStatus> loadingStatus = LoadingStatus.none.obs;
  setLoading() => loadingStatus.value = LoadingStatus.loading;

  Future<void> readUserRandom() async {
    try {
      String url = 'https://randomuser.me/api/?results=5';
      http.Response response = await http.get(Uri.parse(url));
      debugPrint("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        randomUer.value = await compute(parJsonRandomUser, response.body);
        loadingStatus.value = LoadingStatus.done;
      }
    } catch (err) {
      debugPrint("Error: $err");
      loadingStatus.value = LoadingStatus.error;
    } finally {
      notifyChildrens();
    }
  }

  Rx<ProfleModel> getProfile = ProfleModel().obs;
  Future<void> getProfileCtrl() async {
    try {
      String url = mainUrl + profile;
      var token = await _dbHelper.readToken();
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        getProfile.value = await compute(parsJonsProfile, response.body);
        loadingStatus.value = LoadingStatus.done;
      }
    } catch (err) {
      debugPrint("Error: $err");
      loadingStatus.value = LoadingStatus.error;
    } finally {
      notifyChildrens();
    }
  }
}

LoginModel parJsonLogin(String str) => LoginModel.fromJson(json.decode(str));
RandomInfoModel parJsonRandomUser(String str) =>
    RandomInfoModel.fromJson(json.decode(str));
ProfleModel parsJonsProfile(String str) =>
    ProfleModel.fromJson(json.decode(str));
