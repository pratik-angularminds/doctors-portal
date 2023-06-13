import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/Doctor/DocRegister.dart';
import 'package:doctors_portal/Patient/PatientDashboard.dart';
import 'package:doctors_portal/Patient/PatientRegister.dart';
import 'package:doctors_portal/tosters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:page_transition/page_transition.dart';


class PatientLogin extends StatefulWidget {
  const PatientLogin({super.key});

  @override
  State<PatientLogin> createState() => _PatientLogin();
}

class _PatientLogin extends State<PatientLogin> {
  final CollectionReference data =
      FirebaseFirestore.instance.collection('patient');
  String Uname = '', Upass = '';
  Toasters Toast = Toasters();
   checkuser(context)async{
     final id=await SessionManager().get('patient');
    if(id != null)
    {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PatientDashboard()),
      );
      // Navigator.of(context).push(PageTransition(
      //     child: const PatientDashboard(),
      //     type: PageTransitionType.leftToRight));
    }
  }
  @override
  void initState() {
    checkuser(context);
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(children:[Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.elliptical(200, 70)),
                ),
                child: const Center(
                  child: Text(
                    'Patient' "'" 's Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w300),
                  ),
                )),
           Container(
               height: MediaQuery.of(context).size.height * 0.5,
               child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                    child: Container(
                        height: screenheight * 0.1,
                        width: 500,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigoAccent,
                              blurRadius: 10,
                              offset: Offset(1, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (e) {
                            Uname = e.replaceAll(' ', '').toLowerCase();
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.indigoAccent),
                          decoration: InputDecoration(
                            hintText: 'Username',
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(style: BorderStyle.none)),
                            prefixIcon: Container(
                              width: 75,
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigoAccent,
                                    blurRadius: 20,
                                    offset:
                                        Offset(1, 1), // Shadow position
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.mail,
                                  color: Colors.amber, size: 30),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 5),
                    child: Container(
                        height: screenheight * 0.1,
                        width: 500,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigoAccent,
                              blurRadius: 10,
                              offset: Offset(1, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (e) {
                            Upass = e.replaceAll(' ', '');
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.indigoAccent),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(style: BorderStyle.none)),
                            prefixIcon: Container(
                              width: 75,
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigoAccent,
                                    blurRadius: 20,
                                    offset:
                                        Offset(1, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.person,
                                  color: Colors.indigo, size: 30),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: 200,
                    child: TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: const MaterialStatePropertyAll(
                              Colors.indigoAccent),
                          maximumSize: const MaterialStatePropertyAll(
                              Size.square(100.0)),
                          fixedSize:
                              const MaterialStatePropertyAll(Size(200, 50)),
                          textStyle: const MaterialStatePropertyAll(
                              TextStyle(fontSize: 20))),
                      onPressed: () async {
                        if (Uname == '' || Upass == '') {
                          Toast.danger(context, 'Enter Email and Password!!');
                        } else {
                          final querySnapshot = await FirebaseFirestore.instance
                              .collection('patient')
                              .where('mail', isEqualTo: Uname)
                              .get();
                          dynamic list =
                              querySnapshot.docs.map((i) => i.data()).toList();
                          if(!list.isEmpty){
                            if (list[0]['password'] == Upass) {
                              var sessionManager = SessionManager();
                               sessionManager.set("patient", Uname);
                                Toast.success(context, 'Login Successfuly!!');
                              Navigator.of(context).push(PageTransition(
                                  child: const PatientDashboard(),
                                  type: PageTransitionType.leftToRight));
                            } else {
                              Toast.danger(context, 'Wrong Password Entered!');
                            }
                          }
                          else{
                            Toast.danger(context, 'User Not Found!!');
                          }
                        }
                      },
                      child: const Text('Login'),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You don' "'" 't have an account ?'),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.indigoAccent),
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //     PageTransition(
                        //         child: const DocRegister(), type: PageTransitionType.leftToRight)
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientRegister()),
                        );
                      },
                      child: const Text('Sign up'),
                    )
                  ],
                )
              ],
            ))
          ])]),
    );
  }
}
