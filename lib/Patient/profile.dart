import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/Home.dart';
import 'package:doctors_portal/Patient/editprofile.dart';
import 'package:doctors_portal/tosters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'PatientDashboard.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List patient = [];
  var oldPass = TextEditingController();
  var newPass = TextEditingController();
  final CollectionReference app =
      FirebaseFirestore.instance.collection('patient');
  _ProfileState() {
    loadData();
  }
  loadData() async {
    var id = await SessionManager().get('patient');
    QuerySnapshot querySnapshot = await app.where('mail', isEqualTo: id).get();
    setState(() {
      patient = querySnapshot.docs.map((item) => item.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> getPatientID() async {
      final CollectionReference doctors =
          FirebaseFirestore.instance.collection('patient');
      QuerySnapshot querySnapshot1 = await doctors.get();
      dynamic doctorlist =
          querySnapshot1.docs.map((item) => item.data()).toList();
      dynamic count = 0;
      int c = -1;
      final pmail = patient.isNotEmpty ? patient[0]['mail'] : '';
      doctorlist
          .map((item) => item['mail'] == pmail ? c = count : count++)
          .toList();
      dynamic idSarray = querySnapshot1.docs.map((item) => item.id).toList();
      return idSarray[c];
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('My Profile'),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              flex: 1,
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Ink(
                        width: 90,
                        height: 90,
                        decoration: const ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            size: 60,
                          ),
                          color: Colors.white,
                          onPressed: () {},
                        ))),
                Text(
                  patient.isEmpty ? '' : patient[0]['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                )
              ])),
          Expanded(
              flex: 2,
              child: ListView(
                children: [
                  ...ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      leading: Ink(
                        width: 35,
                        decoration: const ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()),
                        );
                      },
                      title: const Text('Edit Profile'),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Enter Old Password'),
                                content: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Password'),
                                  maxLength: 15,
                                  obscureText: true,
                                  controller: oldPass,
                                  validator: (value) {
                                    if (value != null) {
                                      return 'Password is Required';
                                    }
                                    return null;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: const Text('Next'),
                                    onPressed: () {
                                      if (patient[0]['password'] !=
                                              oldPass.text.toString() ||
                                          oldPass.text.isEmpty) {
                                        return Toasters().danger(
                                            context, 'Wrong Password Entered!');
                                      }

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Enter New Password'),
                                              content: TextFormField(controller: newPass,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            'Enter Password'),
                                                maxLength: 15,
                                                obscureText: true,
                                                validator: (value) {
                                                  if (value != null) {
                                                    return 'Password is Required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Back'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                TextButton(
                                                  child: const Text('Submit'),
                                                  onPressed: () async {
                                                    var id =
                                                        await getPatientID();
                                                    if(newPass.text.isEmpty)
                                                      {
                                                        return Toasters().danger(context, 'Password Required!!');
                                                      }
                                                    FirebaseFirestore.instance
                                                        .collection('patient')
                                                        .doc(id)
                                                        .update({
                                                      'password': newPass.text,
                                                    }).then((value) {
                                                      Toasters().success(
                                                          context,
                                                          'Password Updated Successfully!!');
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const PatientDashboard()),
                                                      );
                                                    });
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      leading: Ink(
                        width: 35,
                        decoration: const ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.key),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      title: const Text('Change Password'),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      leading: Ink(
                        width: 35,
                        decoration: const ShapeDecoration(
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.logout),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      onTap: () {
                        SessionManager().destroy();
                        Toasters().success(context, 'Logged out!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()),
                        );
                      },
                      title: const Text('Logout'),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ])
                ],
              ))
        ]));
  }
}
