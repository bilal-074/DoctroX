import 'package:get/get.dart';
import 'package:himsML/api/patient_api.dart';
import 'package:himsML/models/patient_model.dart';

import 'auth_controller.dart';

class PatientController extends GetxController {
  static PatientController get to => Get.find();

  Rx<List<PatientModel>> patientsList = Rx<List<PatientModel>>();

  List<PatientModel> get patients => patientsList.value;

  int get patientsCount => patientsList.value?.length ?? 0;

  @override
  void onInit() {
    //stream coming from firebase
    print("PATIENT CONTROLLER ON INIT");
    String uid = AuthController.to.user.uid;
    patientsList.bindStream(PatientApi().patientStream(uid));
  }

  void rebindStream() {
    String uid = AuthController.to.user.uid;
    patientsList.bindStream(PatientApi().patientStream(uid));
  }

  void clear() {
    patientsList.value = List<PatientModel>();
  }
}
