import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../controllers/auth_controller.dart';

//ignore: must_be_immutable
class SignUpScreen extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormBuilderState>();

  bool validateCredentials() => _signUpFormKey.currentState.saveAndValidate();

  void _submitForm() async {
    if (validateCredentials()) {
      Get.find<AuthController>().createUser(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Sign Up'),
        // leading: Container(),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: FormBuilder(
          key: _signUpFormKey,
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: ListView(
                children: [
                  Column(children: <Widget>[
                    SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'email',
                      controller: _emailController,
                      cursorWidth: 1,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(labelText: 'Email'),
                      valueTransformer: (text) => text.toString().trim(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                        FormBuilderValidators.minLength(context, 8),
                        FormBuilderValidators.maxLength(context, 32),
                      ]),
                    ),
                    SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'password',
                      controller: _passwordController,
                      obscureText: true,
                      cursorWidth: 1,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(labelText: 'Password'),
                      valueTransformer: (text) => text.toString().trim(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(context, 8),
                        FormBuilderValidators.maxLength(context, 64),
                      ]),
                    ),
                    SizedBox(height: 16),
                    FlatButton(
                      onPressed: _submitForm,
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 16),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
