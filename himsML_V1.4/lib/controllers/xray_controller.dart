import 'package:get/get.dart';

import 'package:himsML/models/xray_model.dart';

class XrayController extends GetxController {
  static XrayController get to => Get.find();

  Rx<List<XrayModel>> xrayList = Rx<List<XrayModel>>();

  List<XrayModel> get xrays => xrayList.value;
  int get xrayCount => xrayList.value?.length ?? 0;

  // @override
  // void onInit() {
  //   String uid = Get.find<AuthController>().user.uid;
  //   xrayList
  //       .bindStream(XrayApi().xrayStream(uid)); //stream coming from firebase
  // }

  void clear() {
    xrayList.value = List<XrayModel>();
  }

  // void rebindStream() {
  //   String uid = Get.find<AuthController>().user.uid;
  //   xrayList.bindStream(XrayApi().xrayStream(uid));
  // }
}
