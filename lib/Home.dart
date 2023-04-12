import 'package:doctors_portal/Loading.dart';
import 'package:doctors_portal/Patient/PatientLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'Doctor/DoctorLogin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.medical_services, color: Colors.white),
                label: 'Doctor Login',
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorLogin()),
                  );
                },
                backgroundColor: Colors.blue),
            SpeedDialChild(
                child: const Icon(Icons.person, color: Colors.white),onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PatientLogin()),
              );
            },
                label: 'Patient Login',
                backgroundColor: Colors.blue)
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/medicwall.jpg'),
            fit: BoxFit.contain,
            alignment: Alignment(0, -0.3),
            opacity: 0.7,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin: EdgeInsets.all(70),
                  child:
                      Image.asset('assets/title.png', width: 200, height: 200)),
            ],
          ),
        ));
  }
}
