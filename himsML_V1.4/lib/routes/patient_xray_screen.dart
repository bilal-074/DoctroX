import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:himsML/routes/xray_picker.dart';
import 'package:himsML/api/xray_api.dart';
import 'package:himsML/models/patient_model.dart';
import 'package:himsML/models/xray_model.dart';
import 'package:himsML/controllers/patient_controller.dart';
import 'package:himsML/controllers/auth_controller.dart';
import 'package:himsML/routes/xray_details.dart';

//ignore: must_be_immutable
class PatientXrayScreen extends StatefulWidget {
  final int patientIdx;
  PatientXrayScreen({@required this.patientIdx});
  @override
  _PatientXrayScreenState createState() => _PatientXrayScreenState();
}

class _PatientXrayScreenState extends State<PatientXrayScreen> {
  void _addXray() {
    ///[GO TO XRAY PICKER SCREEN]
    Get.to(XrayPicker(),
        arguments: PatientController.to.patients[widget.patientIdx]);
  }

  void _deleteXray(XrayModel xray) {
    XrayApi().deleteXray(AuthController.to.user.uid, xray);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        title: Text(
            "${PatientController.to.patients[widget.patientIdx].name}'s X-ray(s) "),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => {_addXray()}),
        ],
      ),
      body: Obx(
        () => (PatientController.to.patients != null)
            ? (PatientController.to.patients[widget.patientIdx].xrays.length <
                    1)
                ? Center(child: Container(child: Text('No Xrays')))
                : ListView.builder(
                    itemCount: PatientController
                        .to.patients[widget.patientIdx].xrays.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: [
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () => Get.defaultDialog(
                              title: "Remove Xray ?",
                              content: Icon(Icons.delete),
                              confirmTextColor: Colors.white,
                              onCancel: () {},
                              onConfirm: () {
                                _deleteXray(PatientController.to
                                    .patients[widget.patientIdx].xrays[index]);
                                Get.back();
                              },
                            ),
                          ),
                        ],
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            isThreeLine: true,
                            onTap: () {
                              Get.to(XrayDetailsScreen(xrayIndex: index),
                                  arguments: PatientController
                                      .to.patients[widget.patientIdx]);
                            },
                            title: Text("X-ray: ${index + 1}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            leading: ClipOval(
                              child: Image.file(
                                File(PatientController
                                    .to
                                    .patients[widget.patientIdx]
                                    .xrays[index]
                                    .xrayImageUrl),
                                fit: BoxFit.cover,
                                width: 55.0,
                                height: 90.0,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                text:
                                    "Status: ${PatientController.to.patients[widget.patientIdx].xrays[index].status}\n",
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "Remarks: ${PatientController.to.patients[widget.patientIdx].xrays[index].remarks} "),
                                ],
                              ),
                            ),

                            // trailing: Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     IconButton(
                            //         icon: Icon(Icons.delete,
                            //             color: Colors.redAccent),
                            //         onPressed: () => Get.defaultDialog(
                            //               title: "Remove Xray ?",
                            //               content: Icon(Icons.delete),
                            //               confirmTextColor: Colors.white,
                            //               onCancel: () {},
                            //               onConfirm: () {
                            //                 _deleteXray(PatientController
                            //                     .to
                            //                     .patients[widget.patientIdx]
                            //                     .xrays[index]);
                            //                 Get.back();
                            //               },
                            //             )),
                            //   ],
                            // ),
                          ),
                        ),
                      );
                    },
                  )
            : Center(
                child: Container(
                  child: Text('Controller Null'),
                ),
              ),
      ),
    );
  }
}
