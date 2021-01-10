import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:himsML/api/patient_api.dart';
import 'package:himsML/controllers/patient_controller.dart';
import 'package:himsML/controllers/auth_controller.dart';

class AddPatientScreen extends StatefulWidget {
  final int index;
  AddPatientScreen({@required this.index}) : assert(index != null);
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final _editFormKey = GlobalKey<FormBuilderState>();

  bool validateCredentials() => _editFormKey.currentState.saveAndValidate();
  String getGender() => _editFormKey.currentState.value['gender'];

  void _submitForm() async {
    // validateCredentials();
    // print(getGender());
    // print('val');
    if (validateCredentials()) {
      bool success = await PatientApi().addPatient(
        AuthController.to.user.uid,
        _nameController.text,
        getGender(),
        _ageController.text,
      );
      if (success) {
        Navigator.pop(context);
        Get.snackbar(
          'Success',
          'Patient Added',
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
    _nameController.dispose();
    _genderController.dispose();
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
            'Add Patient Details',
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
                      SizedBox(height: 16),
                      Text("RADIOLOGIST: ${AuthController.to.user.email}"),

                      ///[NAME]
                      FormBuilderTextField(
                        name: 'name',
                        controller: _nameController,
                        cursorWidth: 1,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(labelText: 'Name'),
                        valueTransformer: (text) => text.toString().trim(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 4),
                          FormBuilderValidators.maxLength(context, 16),
                        ]),
                      ),
                      SizedBox(height: 16),

                      ///[GENDER]
                      // FormBuilderTextField(
                      //   name: 'gender',
                      //   controller: _genderController,
                      //   cursorWidth: 1,
                      //   style: TextStyle(fontSize: 18),
                      //   decoration: InputDecoration(labelText: 'Gender'),
                      //   valueTransformer: (text) => text.toString().trim(),
                      //   validator: FormBuilderValidators.compose([
                      //     FormBuilderValidators.required(context),
                      //     FormBuilderValidators.match(
                      //         context, r"\b(male|female|other)\b",
                      //         errorText:
                      //             'gender can only have male, female and other'),
                      //   ]),
                      // ),

                      FormBuilderDropdown(
                        name: 'gender',

                        //  controller: _genderController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                        hint: Text('Select Gender'),
                        items: <String>['Male', 'Female', 'Other']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),

                      /// [AGE]
                      FormBuilderDateTimePicker(
                        name: 'age',
                        inputType: InputType.date,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(labelText: 'Age'),
                        initialValue: DateTime.now(),
                        controller: _ageController,
                      ),
                      // FormBuilderTextField(
                      //   name: 'age',
                      //   controller: _ageController,
                      //   cursorWidth: 1,
                      //   style: TextStyle(fontSize: 18),
                      //   decoration: InputDecoration(labelText: 'age'),
                      //   valueTransformer: (text) => text.toString().trim(),
                      //   validator: FormBuilderValidators.compose([
                      //     FormBuilderValidators.required(context),
                      //     FormBuilderValidators.numeric(context),
                      //     FormBuilderValidators.min(context, 1),
                      //     FormBuilderValidators.max(context, 150)
                      //   ]),
                      // ),
                      SizedBox(height: 16),

                      // ///[EMAIL]
                      // FormBuilderTextField(

                      //   name: 'email',
                      //   readOnly: true,
                      //
                      //   cursorWidth: 1,
                      //   style: TextStyle(fontSize: 18),
                      //   decoration: InputDecoration(
                      //     labelText: 'Email',
                      //     // hintText: 'lisa@mail.com',
                      //   ),
                      // ),
                      SizedBox(height: 16),
                    ])
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
