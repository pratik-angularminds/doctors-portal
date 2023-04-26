import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../tosters.dart';

class AppointmentRequests extends StatefulWidget {
  const AppointmentRequests({Key? key}) : super(key: key);

  @override
  State<AppointmentRequests> createState() => _AppointmentRequestsState();
}

class _AppointmentRequestsState extends State<AppointmentRequests> {
  final CollectionReference app =
      FirebaseFirestore.instance.collection('appointments');
  List doctor = [];
  List appointList = [];
  List patients = [];

  getDoctorID() async {
    var id = await SessionManager().get('doctors');
    final CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors');
    QuerySnapshot querySnapshot =
        await doctors.where('email', isEqualTo: id).get();
    setState(() {
      doctor = querySnapshot.docs.map((item) => item.data()).toList();
    });
    QuerySnapshot querySnapshot1 = await doctors.get();
    dynamic doctorlist =
        querySnapshot1.docs.map((item) => item.data()).toList();
    dynamic count = 0;
    int c = -1;
    final dmail = doctor.isNotEmpty ? doctor[0]['email'] : '';
    doctorlist
        .map((item) => item['email'] == dmail ? c = count : count++)
        .toList();
    List idSarray = querySnapshot1.docs.map((item) => item.id).toList();
    return idSarray[c];
  }

  loadData() async {
    patients = [];
    String docid = await getDoctorID();
    QuerySnapshot querySnapshot =
        await app.where('docId', isEqualTo: docid).get();
    setState(() {
      appointList = querySnapshot.docs.map((item) => item.data()).toList();
    });
    CollectionReference patient =
        FirebaseFirestore.instance.collection('patient');
    DocumentSnapshot querySnapshot1;
    final DateTime now = DateTime.now();
    for (int i = 0; i < appointList.length; i++) {
      querySnapshot1 = await patient.doc(appointList[i]['patientId']).get();
      if (appointList[i]['status'] == 'Booked') {
        if (int.parse(appointList[i]['date'].split('-')[0]) == now.year &&
            int.parse(appointList[i]['date'].split('-')[1]) == now.month &&
            int.parse(appointList[i]['date'].split('-')[2]) >= now.day) {
          setState(() {
            patients.add(
                {'appoint': appointList[i], 'patient': querySnapshot1.data()});
          });
        }
      }
    }
  }

  _AppointmentRequestsState() {
    loadData();
  }

  Future<String> getAppointmentId(appoints) async {
    QuerySnapshot querySnapshot1 = await app.get();
    dynamic appointlist =
        querySnapshot1.docs.map((item) => item.data()).toList();
    dynamic count = 0;
    int c = -1;
    appointlist
        .map((item) => item['patientId'] == appoints['patientId'] &&
                item['date'] == appoints['date'] &&
                item['timeFrom'] == appoints['timeFrom']
            ? c = count
            : count++)
        .toList();
    dynamic idSarray = querySnapshot1.docs.map((item) => item.id).toList();
    return idSarray[c];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          title: const Text('Requests')),
      body: ListView(
        children: [
          ...patients.map((item) => Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 1),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.1))),
              child: ListTile(
                contentPadding: const EdgeInsets.all(5.3),
                style: ListTileStyle.list,
                leading: Image.asset(
                  'assets/patient.png',
                ),
                title: Text(item['patient']['pname'],
                    style: const TextStyle(color: Colors.greenAccent)),
                subtitle: Text(
                    'Date: ${item['appoint']['date']}                  Time: ${item['appoint']['timeFrom']}',
                    style: const TextStyle(fontSize: 13)),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    TextButton(
                        style: const ButtonStyle(
                            textStyle: MaterialStatePropertyAll(
                                TextStyle(color: Colors.white)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blueAccent)),
                        onPressed: () async {
                          final id = await getAppointmentId(item['appoint']);
                          FirebaseFirestore.instance
                              .collection('appointments')
                              .doc(id)
                              .update({
                            'status': 'Confirmed',
                          }).then((value) {
                            Toasters()
                                .success(context, 'Appointment Confirmed!!');
                            loadData();
                          });
                        },
                        child: const Text(
                          'Accept',
                          style: TextStyle(color: Colors.white),
                        )), // icon-1
                    TextButton(
                        style: const ButtonStyle(
                            textStyle: MaterialStatePropertyAll(
                                TextStyle(color: Colors.white)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.redAccent)),
                        onPressed: () async {
                          final id = await getAppointmentId(item['appoint']);
                          FirebaseFirestore.instance
                              .collection('appointments')
                              .doc(id)
                              .update({
                            'status': 'Rejected',
                          }).then((value) {
                            Toasters()
                                .success(context, 'Appointment Rejected!!');
                            loadData();
                          });
                        },
                        child: const Text(
                          'Reject',
                          style: TextStyle(color: Colors.white),
                        )), // icon-2
                  ],
                ),
              )))
        ],
      ),
    );
  }
}
