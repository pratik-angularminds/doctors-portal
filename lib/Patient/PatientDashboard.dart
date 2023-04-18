import 'dart:core';
import 'package:doctors_portal/Patient/TakeAppoint.dart';
import 'package:doctors_portal/Patient/profile.dart';
import 'package:doctors_portal/Patient/view_appointments.dart';
import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xEDEDEDFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.elliptical(200, 80)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      '   welcome...',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ])),
          Expanded(
              child: GridView.count(
            padding: EdgeInsets.fromLTRB(
                screenwidth * 0.1, screenheight * 0.06, screenwidth * 0.1, 0),
            crossAxisSpacing: screenwidth * 0.04,
            mainAxisSpacing: screenheight * 0.01,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TakeAppoint()),
                    );
                    // QuerySnapshot querySnapshot = await doc.get();
                    //  doclist = querySnapshot.docs.map((doc) => doc.data()).toList();
                  },
                  child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/view_appoint.png',
                                width: screenwidth * 0.18,
                              )),
                          const Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Text('Take Appointment',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                    textAlign: TextAlign.center)),
                          )
                        ],
                      ))),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute( builder: (context) => const ViewAppointments()));
                },
                  child:Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/appointment.png',
                            width: screenwidth * 0.18,
                          )),
                      const Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text('View Appointments',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15))),
                      )
                    ],
                  ))),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Profile()),
                  );
                },
                  child:Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Image.asset(
                            'assets/man.png',
                            width: screenwidth * 0.18,
                          )),
                      const Expanded(
                        flex: 1,
                        child: Text('Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                      )
                    ],
                  ))),
              // Card(
              //     elevation: 4,
              //     color: Colors.white,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Expanded(
              //             flex: 3,
              //             child: Image.asset(
              //               'assets/health-checkc-reports.png',
              //               width: screenwidth * 0.18,
              //             )),
              //         const Expanded(
              //           flex: 1,
              //           child: Text('Reports',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.w700, fontSize: 15)),
              //         )
              //       ],
              //     ))
            ],
          ))
        ],
      ),
    );
  }
}
