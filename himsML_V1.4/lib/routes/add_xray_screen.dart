import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:himsML/api/xray_api.dart';
import 'package:himsML/controllers/patient_controller.dart';
import 'package:himsML/controllers/auth_controller.dart';
import 'package:himsML/models/patient_model.dart';
import 'dart:io';

//ignore: must_be_immutable
class AddXrayScreen extends StatefulWidget {
  String xrayImage;
  var inferenceResult;
  AddXrayScreen({@required this.xrayImage, @required this.inferenceResult})
      : assert(xrayImage != null);

  @override
  _AddXrayScreenState createState() => _AddXrayScreenState();
}

class _AddXrayScreenState extends State<AddXrayScreen> {
  PatientModel patientDetails = Get.arguments;

  final TextEditingController _remarksController = TextEditingController();
  // final TextEditingController _statusController = TextEditingController();

  final _editFormKey = GlobalKey<FormBuilderState>();

  bool validateCredentials() => _editFormKey.currentState.saveAndValidate();

  void _submitForm() async {
    if (validateCredentials()) {
      bool success = await XrayApi().addXray(
          AuthController.to.user.uid,
          patientDetails.id,
          widget.inferenceResult["status"].toString(),
          _remarksController.text,
          widget.xrayImage);
      if (success) {
        Navigator.pop(context);
        Navigator.pop(context);
        Get.snackbar(
          'Success',
          'Xray Added',
                  colorText: Colors.white,
        backgroundColor: Colors.blueGrey[900],
        duration: Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          'Error Updating Details',
          'There was an error, please try again',
        colorText: Colors.white,
        backgroundColor: Colors.blueGrey[900],
        duration: Duration(seconds: 5),
        );
      }
    }
  }

  @override
  void dispose() {
    _remarksController.dispose();
    // _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Add X-Ray Details',
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.done,
                ),
                onPressed: _submitForm),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FormBuilder(
          key: _editFormKey,
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Column(children: <Widget>[
                      SizedBox(height: 32),
                      Text(
                        'Confidence: ${widget.inferenceResult["confidence"]}' ??
                            'null',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),

                      /// [STATUS]
                      FormBuilderTextField(
                        name: 'status',
                        readOnly: true,
                        initialValue:
                            widget.inferenceResult["status"].toString(),
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(labelText: 'Status'),
                        valueTransformer: (text) => text.toString().trim(),
                      ),
                      SizedBox(height: 16),

                      ///[REMARKS]
                      FormBuilderTextField(
                        name: 'remarks',
                        controller: _remarksController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(labelText: 'Remarks'),
                        valueTransformer: (text) => text.toString().trim(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 16),
                          FormBuilderValidators.maxLength(context, 64),
                        ]),
                      ),
                      SizedBox(height: 16),
                      Image.file(
                        File(widget.xrayImage),
                        height: MediaQuery.of(context).size.height / 2,
                      )
                    ])
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
