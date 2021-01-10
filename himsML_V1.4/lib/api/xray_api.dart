import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:himsML/controllers/patient_controller.dart';
import 'package:himsML/models/xray_model.dart';

class XrayApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addXray(
    String uid,
    String patientId,
    String status,
    String remarks,
    String xrayImageUrl,
  ) async {
    try {
      await _firestore
          .collection("radiologists")
          .doc(uid)
          .collection("patients")
          .doc(patientId)
          .update({
        'xrays': FieldValue.arrayUnion([
          {
            'patientId': patientId,
            'status': status,
            'remarks': remarks,
            'xrayImageUrl': xrayImageUrl,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          }
        ])
      });

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteXray(String uid, XrayModel xray) async {
    List<dynamic> val =
        []; //blank list for add elements which you want to delete
    val.add(xray);
    print("val[0]");
    print(val[0]);
    print(xray.patientId);
    try {
      await _firestore
          .collection("radiologists")
          .doc(uid.trim())
          .collection("patients")
          .doc(xray.patientId.trim())
          .update({
        'xrays': FieldValue.arrayRemove([
          {
            'patientId': xray.patientId.trim(),
            'status': xray.status,
            'remarks': xray.remarks,
            'xrayImageUrl': xray.xrayImageUrl,
            'timestamp': xray.timestamp,
          }
        ])
      });

      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
