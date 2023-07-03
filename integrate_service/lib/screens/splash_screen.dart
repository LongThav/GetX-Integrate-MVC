import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integrate_service/constant/check_status_user.dart';
import 'package:integrate_service/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CheckToken _checkToken = CheckToken();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      _checkToken.userStatus();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Splash Screen")),
    );
  }
}