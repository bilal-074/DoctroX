import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:himsML/models/xray_model.dart';

class PatientModel {
  String id;
  String radiologistId;
  String name;
  String gender;
  String age;
  String timestamp;
  List<XrayModel> xrays = List<XrayModel>();

  PatientModel({
    this.id,
    this.radiologistId,
    this.name,
    this.gender,
    this.age,
    this.timestamp,
    this.xrays,
  });

  PatientModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    radiologistId = documentSnapshot["radiologistId"];
    name = documentSnapshot["name"];
    gender = documentSnapshot["gender"];
    age = documentSnapshot["age"];
    timestamp = documentSnapshot["timestamp"];
    if (documentSnapshot['xrays'].length == 0) {
      xrays = [];
    } else {
      xrays = documentSnapshot['xrays'].map<XrayModel>((item) {
        return XrayModel.fromMap(item);
      }).toList();
    }
  }
}