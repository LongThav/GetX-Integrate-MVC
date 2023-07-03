import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integrate_service/constant/loading_status.dart';
import 'package:integrate_service/controllers/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    authController.setLoading();
    authController.getProfileCtrl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height * 0.3,
              color: Colors.blue.withOpacity(0.5),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white, size: 30,),
                  onPressed: (){
                    authController.logoutCtrl();
                    authController.isLoading.value = false;
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height * 0.5,
                color: Colors.white,
                child: _buildTile(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.32),
              child:  Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  child: const Icon(Icons.person_outline, size: 80,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(){
    return Obx((){
      switch(authController.loadingStatus.value){
        case LoadingStatus.none:
        case LoadingStatus.loading:
         return const Center(child: CircularProgressIndicator(),);
        case LoadingStatus.error:
         return const Center(child: Text("Error"),);
        case LoadingStatus.done:
         return ListView.builder(
          itemCount: authController.getProfile.value.data.length,
          itemBuilder: (context, index){
            var data = authController.getProfile.value.data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Name: ${data.name}", style: const TextStyle(fontSize: 18),),
                ),
                subtitle: Text("Email: ${data.email}", style: const TextStyle(fontSize: 18),),
              ),
            );
          });
      }
    });
  }
}
