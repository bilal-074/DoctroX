import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:himsML/controllers/patient_controller.dart';
import 'package:flutter/material.dart';

import 'package:himsML/controllers/route_delegate.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User> _firebaseUser = Rx<User>();

  User get user => _firebaseUser.value;

  @override
  onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.put<PatientController>(PatientController(), permanent: true);

      // if (Get.find<PatientController>() == null) {
      //   Get.put<PatientController>(PatientController(), permanent: true);
      // } else {
      //   Get.find<PatientController>().rebindStream();
      // }
      Get.back();
      print("AFTER BACK");
      // signOut();
      // Get.offAll(Root());

    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
                colorText: Colors.white,
        backgroundColor: Colors.blueGrey[900],
        duration: Duration(seconds: 5),
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.put<PatientController>(PatientController(), permanent: true);
      // if (Get.find<PatientController>() == null) {
      //   Get.put<PatientController>(PatientController(), permanent: true);
      // } else {
      //   Get.find<PatientController>().rebindStream();
      // }
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.blueGrey[900],
        duration: Duration(seconds: 5),
      );
    }
  }

  ///[*********  LOGOUT / SIGNOUT  *********]
  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<PatientController>().clear();

      Get.offAll(RouteDelegate());
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
                colorText: Colors.white,
        backgroundColor: Colors.blueGrey[900],
        duration: Duration(seconds: 5),
      );
    }
  }
}
