import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:himsML/models/patient_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String ngrokUrl = '';
Future<void> setNgrokUrl() async {
  DocumentSnapshot result;
  result = await FirebaseFirestore.instance
      .collection('ngrokUrl')
      .doc("6cLgnrJrCJijhNUughzK")
      .get();
  ngrokUrl = result["url"];
  print(ngrokUrl);
}
