import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/Doctor/DocRegisterNext1.dart';
import 'package:doctors_portal/Doctor/DoctorLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocRegister extends StatefulWidget {
  const DocRegister({super.key});

  @override
  _DocRegister createState() => _DocRegister();
}

class _DocRegister extends State<DocRegister> {
  String name = '', mail = '', pass = '', repass = '';

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xECECECFF),
      resizeToAvoidBottomInset: false,
      // 0xECECECFF
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_outline_rounded,
            size: 80,
            color: Colors.white,
          ),
          const Text('Doctor' "'" 's Registration',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
                onChanged: (text) {
                  name = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter Your Name',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person_outline_rounded))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
                onChanged: (text) {
                  mail = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Enter Your Mail',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
                onChanged: (text) {
                  pass = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter Your Password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock_open))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
                onChanged: (text) {
                  repass = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Re-enter your Password',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock))),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.indigoAccent),
                    maximumSize:
                        const MaterialStatePropertyAll(Size.square(100.0)),
                    fixedSize: const MaterialStatePropertyAll(Size(200, 55)),
                    textStyle: MaterialStatePropertyAll(
                        TextStyle(fontSize: screenwidth * 0.05))),
                onPressed: () {
                  // Navigator.of(context).push(
                  //     PageTransition(
                  //         child: DocRegisterNext1(), type: PageTransitionType.rightToLeft)
                  // );
                  // if (repass == pass && repass != '' && pass != '') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DocRegisterNext1(name, mail, pass),
                        // settings: RouteSettings(arguments: {name,mail,pass}),
                      ),
                    );
                  // }
                },
                child: const Text('Next'),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You don' "'" 't have an account ?',
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                style: ButtonStyle(
                  textStyle:
                      const MaterialStatePropertyAll(TextStyle(fontSize: 16)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigoAccent),
                ),
                onPressed: () {
                  Get.to(() => const DoctorLogin(),
                      transition: Transition.zoom);
                },
                child: const Text('Sign In'),
              )
            ],
          )
        ],
      ),
    );
  }
}
