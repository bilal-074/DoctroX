import 'package:cloud_firestore/cloud_firestore.dart';

class XrayModel {
  String xrayId;
  String patientId;
  String status;
  String remarks;
  String xrayImageUrl;
  String timestamp;

  XrayModel({
    this.xrayId,
    this.patientId,
    this.status,
    this.remarks,
    this.xrayImageUrl,
    this.timestamp,
  });

  XrayModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    xrayId = documentSnapshot.id;
    patientId = documentSnapshot["patientId"];
    status = documentSnapshot["status"];
    remarks = documentSnapshot["remarks"];
    xrayImageUrl = documentSnapshot["xrayImageUrl"];
    timestamp = documentSnapshot["timestamp"];
  }

  XrayModel.fromMap(Map<dynamic, dynamic> data)
      : xrayId = data["xrayId"],
        patientId = data["patientId"],
        status = data["status"],
        remarks = data["remarks"],
        xrayImageUrl = data["xrayImageUrl"],
        timestamp = data["timestamp"];
}