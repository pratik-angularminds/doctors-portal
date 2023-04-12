import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/Doctor/DoctorLogin.dart';
import 'package:doctors_portal/Patient/PatientDashboard.dart';
import 'package:flutter/material.dart';

class DocRegisterNext1 extends StatelessWidget {
  String name = '',
      mail = '',
      pass = '',
      add = '',
      city = '',
      deg = '',
      spec = '';
  final CollectionReference doc =
      FirebaseFirestore.instance.collection('doctors');
  DocRegisterNext1(this.name, this.mail, this.pass, {super.key});
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
            padding: const EdgeInsets.all(20),
            child: TextField(
                onChanged: (text) {
                  add = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter Address',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.location_on_outlined))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
                onChanged: (text) {
                  city = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'City',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.location_city_rounded),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
                onChanged: (text) {
                  deg = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Degree',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.grade))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
                onChanged: (text) {
                  spec = text;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Specialists',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.favorite_border_rounded))),
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
                onPressed: () async {
                  if (name != '' &&
                      pass != '' &&
                      pass != '' &&
                      mail != '' &&
                      add != '' &&
                      city != '' &&
                      deg != '' &&
                      spec != '') {
                    await doc.add({
                      'name': name,
                      'password': pass,
                      'email': mail,
                      'address': add,
                      'city': city,
                      'degree': deg,
                      'speciality': spec
                    });
                  }
                  // dynamic data=doc.snapshots();
                  // print(data.data);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PatientDashboard()),
                  // );
                },
                child: const Text('Login'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DoctorLogin()),
                  );
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
