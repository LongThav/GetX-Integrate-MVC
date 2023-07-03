import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integrate_service/dashboard_screen.dart';
import 'package:integrate_service/db_helper/cache_token.dart';
import 'package:integrate_service/screens/login_screen.dart';

class CheckToken{
  void userStatus()async{
    DBHelper dbHelper = DBHelper();
    var token = await dbHelper.readToken();
    debugPrint("Token: $token");
    if(token == dbHelper.noToken){
      Get.off(()=>const LoginScreen());
    }else{
      Get.off(()=>const DashBoardScreen());
    }
  }
}