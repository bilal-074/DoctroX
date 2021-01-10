import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:himsML/routes/login_screen.dart';
import 'package:himsML/controllers/auth_controller.dart';
import 'package:himsML/routes/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:himsML/controllers/xray_controller.dart';

// class RouteDelegate extends GetWidget<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() =>
//     ///[dont forget to switch this statment]
//         (AuthController.to.user?.uid != null) ? HomeScreen() :  LoginScreen());

//   }
// }

class RouteDelegate extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return

        // GetX(
        // initState: (_) async {
        //   Get.put<UserController>(UserController());
        //   Get.lazyPut<FollowerController>(()=>FollowerController());
        //   Get.lazyPut<FollowingController>(()=>FollowingController());
        //   Get.lazyPut<PostController>(()=>PostController());
        // },
        // builder: (_) {
        // print("USER ID: ${Get.find<AuthController>().user?.uid}");
        Obx(() => (AuthController.to.user?.uid != null)
            ?
            // print("SUCCESS USER ID: ${Get.find<AuthController>().user?.uid}");
            HomeScreen()
            :
            // print("FAIL USER ID: ${Get.find<AuthController>().user?.uid}");
            LoginScreen());
    // },
    // );
  }

  // Widget build(BuildContext context) {
  //   return GetX<AuthController>(
  //     initState: (_) async {
  //       var status = await Permission.storage.status;
  //       if (!status.isGranted) {
  //         await Permission.storage.request();
  //       }
  //       // Get.put<PatientController>(PatientController(), permanent: true);
  //       // Get.put<XrayController>(XrayController(), permanent: true);
  //     },
  //     builder: (_) {
  //       print("USER ID: ${Get.find<AuthController>().user?.uid}");
  //       if (AuthController.to.user?.uid != null) {
  //         print("SUCCESS USER ID: ${Get.find<AuthController>().user?.uid}");
  //         return HomeScreen();
  //       } else {
  //         print("FAIL USER ID: ${Get.find<AuthController>().user?.uid}");
  //         return LoginScreen();
  //       }
  //     },
  //   );
  // }
}
