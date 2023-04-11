import 'package:doctors_portal/DocRegister.dart';
import 'package:doctors_portal/DocRegisterNext1.dart';
import 'package:doctors_portal/DoctorLogin.dart';
import 'package:doctors_portal/Home.dart';
import 'package:doctors_portal/Loading.dart';
import 'package:doctors_portal/Patient/PatientDashboard.dart';
import 'package:doctors_portal/Patient/PatientLogin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: Home(),
  ));
}

// initialRoute: '/home',
// routes: {
// '/': (context) => const Loading(),
// '/home': (context) => const Home(),
// '/docregister': (context) => const DocRegister(),
// '/docregisternext1': (context) => const DocRegisterNext1(),
// },
