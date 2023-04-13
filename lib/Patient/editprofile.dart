import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/tosters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'PatientDashboard.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List patient = [];
  var name = TextEditingController();
  var email = TextEditingController();
  var contact = TextEditingController();
  final CollectionReference app =
      FirebaseFirestore.instance.collection('patient');
  _EditProfileState() {
    loadData();
  }
  loadData() async {
    var id = await SessionManager().get('patient');
    QuerySnapshot querySnapshot = await app.where('mail', isEqualTo: id).get();
    setState(() {
      patient = querySnapshot.docs.map((item) => item.data()).toList();
    });
    name.text = patient[0]['pname'];
    email.text = patient[0]['mail'];
    contact.text = patient[0]['contact'];
  }

  Future<String> getPatientID() async {
    final CollectionReference patients =
        FirebaseFirestore.instance.collection('patient');
    QuerySnapshot querySnapshot1 = await patients.get();
    dynamic patientlist =
        querySnapshot1.docs.map((item) => item.data()).toList();
    dynamic count = 0;
    int c = -1;
    final pmail = patient.isNotEmpty ? patient[0]['mail'] : '';
    patientlist
        .map((item) => item['mail'] == pmail ? c = count : count++)
        .toList();
    dynamic idSarray = querySnapshot1.docs.map((item) => item.id).toList();
    return idSarray[c];
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: const Text('Edit Profile'),
          actions: [
            TextButton(
                onPressed: () async {
                  var id = await getPatientID();
                  FirebaseFirestore.instance
                      .collection('patient')
                      .doc(id)
                      .update({
                    'pname': name.text,
                    'contact': contact.text,
                    'mail': email.text,
                  }).then((value){
                            Toasters().success(
                                context, 'Profile Updated Successfully!!');
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const PatientDashboard()),
                  );
                          });
                  SessionManager().set('patient',email.text);
                  loadData();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                height: screenheight * 0.2,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.orangeAccent,
                          Colors.red,
                          Colors.redAccent
                          //add more colors for gradient
                        ],
                        begin: Alignment.topLeft, //begin of the gradient color
                        end: Alignment.bottomRight, //end of the gradient color
                        stops: [0, 0.2, 0.5, 0.8]),
                    color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Container(
                        width: 60,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.person, size: 30),
                          color: Colors.indigoAccent,
                          onPressed: () {},
                        ),
                      ),
                      title: Text(
                        patient.isEmpty ? '' : patient[0]['pname'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      subtitle: const Text(
                        'Online',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              )),
          const Spacer(),
          Expanded(
              flex: 1,
              child: SizedBox(
                  width: screenwidth * 0.8,
                  child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.indigoAccent),
                          ),
                          label: Text(
                            'NAME',
                            style: TextStyle(color: Colors.grey),
                          ))))),
          Expanded(
              flex: 1,
              child: SizedBox(
                  width: screenwidth * 0.8,
                  child: TextField(
                      controller: email,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.indigoAccent),
                          ),
                          label: Text(
                            'E-MAIL',
                            style: TextStyle(color: Colors.grey),
                          ))))),
          Expanded(
              flex: 3,
              child: SizedBox(
                  width: screenwidth * 0.8,
                  child: TextField(
                      controller: contact,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 2, color: Colors.indigoAccent),
                          ),
                          label: Text(
                            'CONTACT',
                            style: TextStyle(color: Colors.grey),
                          ))))),
        ],
      ),
    );
  }
}
