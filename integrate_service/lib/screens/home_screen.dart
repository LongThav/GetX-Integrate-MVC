import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integrate_service/constant/loading_status.dart';
import 'package:integrate_service/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    authController.setLoading();
    authController.readUserRandom();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("List User"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Obx((){
      switch(authController.loadingStatus.value){
        case LoadingStatus.none:
        case LoadingStatus.loading:
         return const Center(child: CircularProgressIndicator(),);
        case LoadingStatus.error:
         return const Center(child: Text("Error"),);
        case LoadingStatus.done:
         return _buildItem();
      }
    });
  }

  Widget _buildItem(){
    var userRandom = authController.randomUer;
    return Obx((){
      return RefreshIndicator(
        onRefresh: ()async{
          authController.setLoading();
          authController.readUserRandom();
        },
        child: ListView.builder(
          itemCount: userRandom.value.results.length,
          itemBuilder: (context, index){
            var data = userRandom.value.results[index];
            return ListTile(
              leading: Text(data.id.name),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(data.email),
              ),
              subtitle: Container(
                width: 50,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(data.picture.medium),
                    fit: BoxFit.fill
                  )
                ),
              ),
            );
          }
        ),
      );
    });
  }
}