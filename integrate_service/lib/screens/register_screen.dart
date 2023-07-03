import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integrate_service/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Get.back();
            authController.isLoading.value = false;
          },
        ),
        title: const Text("Register Screen"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Name'),
          ),
        ),
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
        Obx(() {
          return InkWell(
            onTap: () {
              if (_nameCtrl.text.isEmpty) {
                // Get.rawSnackbar(title: 'Please input your name');
                Get.snackbar('Please input your name', '');
              } else if (_emailCtrl.text.isEmpty) {
                Get.snackbar('Please input your email','');
              } else if (_passwordCtrl.text.isEmpty ||
                  _passwordCtrl.text.length < 6) {
                Get.snackbar('Please input your password', '');
              } else {
                authController
                    .registerCtrl(
                        _nameCtrl.text, _emailCtrl.text, _passwordCtrl.text);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(12)),
              child: authController.isLoading.value? const Center(child: CircularProgressIndicator(
                color: Colors.white,
              )) : const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ), 
            ),
          );
        })
      ],
    );
  }
}
