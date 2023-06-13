import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
      if (int.parse(appointList[i]['date'].split('-')[0]) <= now.year &&
          int.parse(appointList[i]['date'].split('-')[1]) <= now.month &&
          int.parse(appointList[i]['date'].split('-')[2]) < now.day) {
        setState(() {
          patients.add(
              {'appoint': appointList[i], 'patient': querySnapshot1.data()});
        });
      }
    }
  }

  _HistoryState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          backgroundColor: Colors.indigoAccent, title: const Text('History')),
      body: ListView(
        children: [
          ...patients.map((item) => Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 1),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.1))),
              child: ListTile(
                contentPadding: const EdgeInsets.all(5),
                style: ListTileStyle.list,
                leading: Image.asset(
                  'assets/patient.png',
                ),
                title: Text(item['patient']['pname'],
                    style: const TextStyle(color: Colors.greenAccent)),
                subtitle: Text(
                    'Date: ${item['appoint']['date']}   Time: ${item['appoint']['timeFrom']}',
                    style: const TextStyle(fontSize: 13)),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '${item['appoint']['status']}',
                          style: const TextStyle(color: Colors.greenAccent),
                        )), // icon-1
                  ],
                ),
              )))
        ],
      ),
    );
  }
}
