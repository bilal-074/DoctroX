import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:himsML/models/patient_model.dart';

class PatientApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PatientModel>> patientStream(String uid) {
    print("CANCER");
    print(uid);
    return _firestore
        .collection("radiologists")
        .doc(uid.trim())
        .collection("patients")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PatientModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(PatientModel.fromDocumentSnapshot(element));
        print(element.id);
      });

      return retVal;
    });
  }

  Future<bool> addPatient(
      String uid, String name, String gender, String age) async {
    try {
      await _firestore
          .collection("radiologists")
          .doc(uid.trim())
          .collection("patients")
          .add({
        'radiologistId': uid,
        'name': name,
        'gender': gender,
        'age': age,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'xrays': [],
      });
      return true;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deletePatient(String uid, String patientId) async {
    try {
      await _firestore
          .collection("radiologists")
          .doc(uid.trim())
          .collection("patients")
          .doc(patientId.trim())
          .delete();
      print("Deleted Successfully");
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
