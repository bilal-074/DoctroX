import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../controllers/auth_controller.dart';
import 'package:himsML/routes/signup_screen.dart';

class LoginScreen extends GetWidget<AuthController> {
  final _loginFormKey = GlobalKey<FormBuilderState>();

  bool validateCredentials() => _loginFormKey.currentState.saveAndValidate();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (validateCredentials()) {
      Get.find<AuthController>()
          .login(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        centerTitle: true,
        title: Text('Login'),
      ),
      body: GestureDetector(
        child: FormBuilder(
          key: _loginFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            child: ListView(
              children: [
                Column(children: <Widget>[
                  // SizedBox(height: 16),
                  SizedBox(height: 225),
                  FormBuilderTextField(
                    name: 'email',
                    controller: _emailController,
                    cursorWidth: 1,
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(labelText: 'Password'),
                    valueTransformer: (text) => text.toString(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.minLength(context, 8),
                      FormBuilderValidators.maxLength(context, 64),
                    ]),
                  ),
                  SizedBox(height: 32),
                  OutlineButton(
                    highlightColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: _submitForm,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => Get.to(SignUpScreen()),
                    child: Text(
                      "Don't have an account? Sign up.",
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
