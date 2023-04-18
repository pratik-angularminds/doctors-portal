import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'ViewAppointmentSingle.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({Key? key}) : super(key: key);

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  final CollectionReference app =
  FirebaseFirestore.instance.collection('appointments');
  List doctor = [];
  List appointList = [];
  List patients = [];

  getDoctorID() async {
    var id = await SessionManager().get('patient');
    final CollectionReference doctors =
    FirebaseFirestore.instance.collection('patient');
    QuerySnapshot querySnapshot =
    await doctors.where('mail', isEqualTo: id).get();
    setState(() {
      doctor = querySnapshot.docs.map((item) => item.data()).toList();
    });
    QuerySnapshot querySnapshot1 = await doctors.get();
    dynamic doctorlist =
    querySnapshot1.docs.map((item) => item.data()).toList();
    dynamic count = 0;
    int c = -1;
    final dmail = doctor.isNotEmpty ? doctor[0]['mail'] : '';
    doctorlist
        .map((item) => item['mail'] == dmail ? c = count : count++)
        .toList();
    List idSarray = querySnapshot1.docs.map((item) => item.id).toList();
    return idSarray[c];
  }

  loadData() async {
    String docid = await getDoctorID();
    QuerySnapshot querySnapshot =
    await app.where('patientId', isEqualTo: docid).get();
    setState(() {
      appointList = querySnapshot.docs.map((item) => item.data()).toList();
    });
    CollectionReference patient =
    FirebaseFirestore.instance.collection('doctors');
    DocumentSnapshot querySnapshot1;
    for (int i = 0; i < appointList.length; i++) {
      querySnapshot1 = await patient.doc(appointList[i]['docId']).get();
          setState(() {
            patients.add(
                {'appoint': appointList[i], 'doctor': querySnapshot1.data()});
          });
    }
    print(patients);
  }
_ViewAppointmentsState(){
    loadData();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigoAccent, title: const Text('Appointments')),
      body: ListView(
        children: [
          ...patients.map((item) => Container(
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.4))),
              child: ListTile(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(builder)=> ViewAppointmentSingle(item)));
              },
                contentPadding: const EdgeInsets.all(5),
                style: ListTileStyle.list,
                leading: Image.asset(
                  'assets/Icons/doctor.png',
                ),
                title: Text(item['doctor']['name'],
                    style: const TextStyle(color: Colors.greenAccent)),
                subtitle: Text(
                    'Date: ${item['appoint']['date']}   Time: ${item['appoint']['timeFrom']}',
                    style: const TextStyle(fontSize: 13)),
              )))
        ],
      ),
    );
  }
}
