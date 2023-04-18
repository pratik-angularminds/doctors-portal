import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/tosters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../Patient/PatientDashboard.dart';

class ConfirmAppoint extends StatefulWidget {
  final dynamic finalslot,doctor;
  const ConfirmAppoint({super.key, this.doctor,this.finalslot});

  @override
  State<ConfirmAppoint> createState() => _ConfirmAppointState();
}

class _ConfirmAppointState extends State<ConfirmAppoint> {
   dynamic Finalslot = {
    'slot': '',
    'status': '',
    'date': '',
  },doctor={};
   final CollectionReference app =
   FirebaseFirestore.instance.collection('appointments');
  @override
  Widget build(BuildContext context) {
    Finalslot=widget.finalslot;
    doctor=widget.doctor;

    Future<String> getDoctorID(doc) async {
      final CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');
      QuerySnapshot querySnapshot1 = await doctors.get();
      dynamic doctorlist =
      querySnapshot1.docs.map((item) => item.data()).toList();
      dynamic count = 0;
      int c = -1;
      doctorlist
          .map((item) => item['email'] == doc['email'] ? c = count : count++)
          .toList();
      dynamic idSarray = querySnapshot1.docs.map((item) => item.id).toList();
      return idSarray[c];
    }

    Future<String> getPatientId(email) async {
      final CollectionReference doctors =
      FirebaseFirestore.instance.collection('patient');
      QuerySnapshot querySnapshot1 = await doctors.get();
      dynamic patientlist =
      querySnapshot1.docs.map((item) => item.data()).toList();
      dynamic count = 0;
      int c = -1;
      patientlist
          .map((item) => item['mail'] == email ? c = count : count++)
          .toList();
      dynamic idSarray = querySnapshot1.docs.map((item) => item.id).toList();
      return idSarray[c];
    }
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Row(children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(color: Color(0xFFDAFBDF)),
            child: const Icon(
              Icons.check_circle,
              size: 150,
              color: Colors.green,
            ),
          ))
        ]),
        Column(children: [
          const Text('THANK YOU FOR CHOOSING OUR SERVICE !',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey)),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              width: screenwidth * 0.88,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1))),
              child: const Text(
                'APPOINTMENT  INFORMATION',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              width: screenwidth * 0.94,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_month, color: Colors.blue),
                  Text('   ${Finalslot['date']} at ${Finalslot['slot']}')
                ],
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              width: screenwidth * 0.94,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.blue),
                  Text('   ${doctor['name']}')
                ],
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              width: screenwidth * 0.88,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1)))),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              width: screenwidth * 0.94,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.local_hospital, color: Colors.blue),
                  Text('   ${doctor['address']}')
                ],
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              width: screenwidth * 0.94,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.call, color: Colors.blue),
                  Text('   ${doctor['contact']}')
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child:
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                height: 45,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child:TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.indigoAccent),
                  textStyle:
                      const MaterialStatePropertyAll(TextStyle(fontSize: 16)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigoAccent),
                ),
                onPressed: () async {
                  final id =await getDoctorID(doctor);
                  final patientEmail=await SessionManager().get('patient');
                  final pid =await getPatientId(patientEmail);
                      await app.add({
                      'date': Finalslot['date'],
                      'docId': id,
                      'patientId': pid,
                      'status': Finalslot['status'],
                      'timeFrom': Finalslot['slot'],
                      'timeTo': '',
                    }).then((value) => {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => const PatientDashboard())),
                    Toasters().success(context, 'Appointment Request Successfully Sent!!')
                    });

                },
                child: const Text('Confirm',style: TextStyle(color: Colors.white)),
              )))
            ],
          )
        ])
      ],
    ));
  }
}
