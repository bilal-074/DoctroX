import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:himsML/routes/add_patient_screen.dart';
import 'package:himsML/api/patient_api.dart';
import 'package:himsML/controllers/patient_controller.dart';
import 'package:himsML/controllers/auth_controller.dart';
import 'package:himsML/routes/patient_xray_screen.dart';
import 'package:himsML/global.dart' as global;

//ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _dateFromTimestamp(String timestamp) {
    int t = int.parse(timestamp);
    String date =
        DateTime.fromMillisecondsSinceEpoch(t).toString().substring(0, 10);
    return date;
  }

  void _deletePatient(String patientId) {
    PatientApi().deletePatient(AuthController.to.user.uid, patientId);
    print("_deletePatient");
  }

  // Future<void> getPermission() async {
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  // }

  Future<void> getPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    await global.setNgrokUrl();
  }

  @override
  void initState() {
    getPermission();
    try {
      if (PatientController.to == null) {
        print("error");
      } else {
        PatientController.to.rebindStream();
      }
    } catch (e) {
      Get.put<PatientController>(PatientController(), permanent: true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Patients'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {
                    Get.to(AddPatientScreen(
                      index: 0,
                    ))
                  }),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => AuthController.to.signOut()),
        ],
      ),
      body: Obx(
        () => (PatientController.to != null)
            ? (PatientController.to.patientsCount == 0)
                ? Center(child: Text('No Patients'))
                : ListView.builder(
                    itemCount: PatientController.to.patientsCount,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: [
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () => Get.defaultDialog(
                              title: "Remove Patient ?",
                              content: Icon(Icons.delete),
                              confirmTextColor: Colors.white,
                              onCancel: () {},
                              onConfirm: () {
                                _deletePatient(
                                    PatientController.to.patients[index].id);
                                Get.back();
                              },
                            ),
                          )
                        ],
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              Get.to(PatientXrayScreen(patientIdx: index));
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            isThreeLine: true,
                            title: Text(
                                PatientController.to.patients[index].name
                                    .toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: RichText(
                              text: TextSpan(
                                text:
                                    "X-rays: ${PatientController.to.patients[index].xrays.length}\n",
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Gender: ${PatientController.to.patients[index].gender}\n"),
                                  TextSpan(
                                      text:
                                          "DOB: ${PatientController.to.patients[index].age}\n"),
                                  TextSpan(
                                      text:
                                          "Added on: ${_dateFromTimestamp(PatientController.to.patients[index].timestamp)}",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),

                            // trailing: Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     IconButton(
                            //       icon: Icon(Icons.delete,
                            //           color: Colors.redAccent),
                            //       onPressed: () => Get.defaultDialog(
                            //         title: "Remove Patient ?",
                            //         content: Icon(Icons.delete),
                            //         confirmTextColor: Colors.white,
                            //         onCancel: () {},
                            //         onConfirm: () {
                            //           _deletePatient(PatientController
                            //               .to.patients[index].id);
                            //           Get.back();
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),

                          ),
                        ),
                      );
                    },
                  )
            : Center(child: Container(child: Text('Controller Null'))),
      ),
    );
  }
}
