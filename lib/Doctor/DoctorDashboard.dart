import 'package:doctors_portal/Doctor/ConfirmedAppointments.dart';
import 'package:doctors_portal/Doctor/History.dart';
import 'package:doctors_portal/Doctor/doctorProfile.dart';
import 'package:flutter/material.dart';

import 'AppointmentRequests.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body:ListView(children:[ Column(
      children: [
       Padding(padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),child: SizedBox(
            height: screenheight * 0.15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('welcome',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300)),
                Image.asset(
                  'assets/Icons/doctor.png',
                  fit: BoxFit.cover,
                  height: screenheight * 0.12,
                ),
              ],
            ))),
        Container(alignment: Alignment.center,
            height: screenheight*0.85,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius:BorderRadius.only(topLeft: Radius.elliptical(350, 250))
            ),
            child:
            Container(margin: EdgeInsets.fromLTRB(0, screenheight*0.2, 0, 0),
                // mainAxisAlignment: MainAxisAlignment.end,
                // children: [
                //  Expanded(
                //      child:
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
                                  builder: (context) => const AppointmentRequests()),
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
                                        'assets/appointment.png',
                                        width: screenwidth * 0.18,
                                      )),
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Text('Appointments Requests',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                            textAlign: TextAlign.center)),
                                  )
                                ],
                              ))),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => const ConfirmedAppointments()),
                         );
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
                                    'assets/medical-history.png',
                                    width: screenwidth * 0.18,
                                  )),
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Text('Confirmed Appointments',
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
                                  builder: (context) => const DoctorProfile()),
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
                                        'assets/myprofiledoctor.png',
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
                      GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const History()),
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
                                        'assets/medical-history-appoints.png',
                                        width: screenwidth * 0.18,
                                      )),
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Text('Appointments History',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                            textAlign: TextAlign.center)),
                                  )
                                ],
                              )))
                    ],
                  )
                 // )]
              )
        ),
      ],
    )]));
  }
}
