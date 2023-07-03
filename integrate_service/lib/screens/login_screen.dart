import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integrate_service/controllers/auth_controller.dart';
import 'package:integrate_service/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  
  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text("Login Screen"),
    );
  }

  Widget get _buildBody {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: _emailCtrl,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Email'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: _passwordCtrl,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Password'),
          ),
        ),
        Obx((){
          return InkWell(
          onTap: () {
            if (_emailCtrl.text.isEmpty) {
              Get.snackbar('Please input email', '');
            } else if (_passwordCtrl.text.isEmpty) {
              Get.snackbar('Please input password', ' ');
            } else {
              authController.loginCtrl(_emailCtrl.text, _passwordCtrl.text);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(12)),
            child: authController.isLoading.value ? const Center(child: CircularProgressIndicator(
              color: Colors.white,
            ),): const Center(
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        );
        }),
        TextButton(
            onPressed: () {
              Get.to(() => const RegisterScreen());
            },
            child: const Text("Register"))
      ],
    );
  }
}
