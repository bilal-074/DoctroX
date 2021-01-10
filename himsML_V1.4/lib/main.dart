import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himsML/controllers/route_delegate.dart';
import 'package:himsML/controllers/bindings/auth_binding.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(Hims());
}

class Hims extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyanAccent[400],
        scaffoldBackgroundColor: Colors.cyan[50],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.cyan[900]),
        ),
      ),
      title: 'Hims ML',
      initialBinding: AuthBinding(),
      home: RouteDelegate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
