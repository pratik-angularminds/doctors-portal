import 'dart:math';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/Patient/PatientDashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  final dynamic doc;

  const Calender(this.doc, {super.key});

  @override
  State<Calender> createState() => _MyHomePageState(doc);
}

class Slots {
  String? time;
  bool completed = false,
      selected = false,
      rejected = false,
      lunch = true,
      booked = false,
      confirmed = false;

  Slots(
      {this.time,
      required this.confirmed,
      required this.rejected,
      required this.completed,
      required this.booked,
      required this.lunch,
      required this.selected});
}

class _MyHomePageState extends State<Calender> {
  DateTime? selectedDate;
  Random random = Random();
  final CollectionReference app =
      FirebaseFirestore.instance.collection('appointments');
  List applist = [];
  List list = [];
  String changedDate = '';
  dynamic finalSlot = {
    'slot': '',
    'status': '',
    'date': '',
  };
  late dynamic tempapplist = [];
  final List<String> time = [
    '10:00AM',
    '10:30AM',
    '11:00AM',
    '11:30AM',
    '12:00AM',
    '12:30AM',
    '01:00PM',
    '01:30PM',
    '02:00PM',
    '02:30PM',
    '03:00PM',
    '03:30PM',
    '04:00PM',
    '04:30PM',
    '05:00PM',
    '05:30PM',
    '06:00PM',
    '06:30PM',
    '07:00PM',
    '07:30PM',
    '08:00PM'
  ];
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  dynamic doc;

  _MyHomePageState(this.doc);

  // String formatted = formatter.format(now);

  @override
  void initState() {
    setState(() {
      selectedDate = DateTime.now();
    });
    super.initState();
    loadData();
  }

  Future<String> getDoctorID() async {
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

  loadData() async {
    var docId = await getDoctorID();
    QuerySnapshot querySnapshot =
        await app.where('docId', isEqualTo: docId).get();
    // String formatted = formatter.format(now);
    setState(() {
      list = querySnapshot.docs.map((doc) => doc.data()).toList();
      applist = list
          .where((e) =>
              int.parse(e['date'].split('-')[2]) == now.day &&
              int.parse(e['date'].split('-')[1]) == now.month &&
              int.parse(e['date'].split('-')[0]) == now.year)
          .toList();
    });
    setState(() {
      time
          .map((i) => tempapplist.add(Slots(
              time: i,
              confirmed: false,
              completed: false,
              rejected: false,
              booked: false,
              lunch: i == '12:00AM' || i == '12:30AM' ? true : false,
              selected: false)))
          .toList();
    });
  }

  Widget slotPreview(capplist) {
    print(capplist);
    if (!capplist.isEmpty) {
      tempapplist
          .map((item) => {
                for (int i = 0; i < capplist.length; i++)
                  {
                    if (capplist[i]['timeFrom'] == item.time)
                      {
                        capplist[i]['status'] == 'Completed'
                            ? item.completed = true
                            : item.completed = false,
                        capplist[i]['status'] == 'Confirmed'
                            ? item.confirmed = true
                            : item.confirmed = false,
                        capplist[i]['status'] == 'Booked'
                            ? item.booked = true
                            : item.booked = false,
                        capplist[i]['status'] == 'Rejected'
                            ? item.rejected = true
                            : item.rejected = false,
                      }
                    else
                      {
                        item.completed = false,
                        item.confirmed = false,
                        item.booked = false,
                        item.rejected = false,
                      }
                  }
              })
          .toList();
    }
    if (capplist.isEmpty) {
      tempapplist
          .map((item) => {
                item.completed = false,
                item.confirmed = false,
                item.booked = false,
                item.rejected = false,
              })
          .toList();
    }

    return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: const EdgeInsets.all(10),
        children: [
          ...tempapplist
              .map((item) => GestureDetector(
                  onTap: () {
                    setState(() {
                      tempapplist
                          .map((i) => i == item
                              ? i.selected = !i.selected
                              : i.selected = false)
                          .toList();
                    });
                    if (finalSlot['slot'] == item.time) {
                      finalSlot['slot'] = '';
                      finalSlot['status'] = '';
                      finalSlot['date'] = changedDate;
                    } else {
                      finalSlot['slot'] = item.time;
                      finalSlot['status'] = 'Booked';
                      finalSlot['date'] = changedDate;
                    }
                  },
                  child: Card(
                    color: item.lunch
                        ? Colors.grey
                        : item.completed
                            ? Colors.greenAccent
                            : item.confirmed
                                ? Colors.grey[350]
                                : item.rejected
                                    ? Colors.redAccent
                                    : item.booked
                                        ? Colors.indigoAccent
                                        : item.selected
                                            ? Colors.yellowAccent
                                            : Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.time.toString(),
                            style: TextStyle(
                                color: item.completed ||
                                        item?.lunch ||
                                        item.booked ||
                                        item.confirmed ||
                                        item.rejected
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          Container(
                            child: item?.lunch
                                ? const Text(
                                    'Lunch',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : item.completed
                                    ? const Text(
                                        'Completed',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : item.confirmed
                                        ? const Text(
                                            'Confirmed',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : item.rejected
                                            ? const Text(
                                                'Rejected',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : item.booked
                                                ? const Text(
                                                    'Booked',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : !item.booked
                                                    ? const Text('Available')
                                                    : const Text(''),
                          )
                        ]),
                  )))
              .toList()
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CalendarAppBar(
          firstDate: now,
          locale: 'en',
          lastDate: DateTime.now().add(const Duration(days: 15)),
          onDateChanged: (value) {
            String formatted = formatter.format(value);
            changedDate = formatted;
            setState(() {
              applist = list
                  .where(
                      (e) => int.parse(e['date'].split('-')[2]) == value?.day)
                  .toList();
              tempapplist
                  .map((item) => {
                        item.completed = false,
                        item.booked = false,
                        item.selected = false
                      })
                  .toList();
            });
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (finalSlot['slot'] == '') {
              var snackBar =
                  const SnackBar(content: Text('Please Select Slot!'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              Widget cancelButton = TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              );
              Widget continueButton = TextButton(
                child: const Text("Confirm"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientDashboard()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color(0xFF66BB6A),
                      content: Text('Successfully Appointment Booked')));
                },
              );
              AlertDialog alert = AlertDialog(
                title: const Text("Confirmation"),
                content: const Text(
                    "Would you like to continue with selected slots"),
                actions: [
                  cancelButton,
                  continueButton,
                ],
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          },
          label: const Text('Appointment'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.indigoAccent,
        ),
        backgroundColor: const Color(0xEDEDEDFF),
        body: slotPreview(applist));
  }
}
