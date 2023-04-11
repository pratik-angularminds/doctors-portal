import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/DocRegister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'Users/Patient.dart';

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  _DoctorLogin createState() => _DoctorLogin();
}

class _DoctorLogin extends State<DoctorLogin> {
  String Uname='' ,Upass='';
  final CollectionReference data =
  FirebaseFirestore.instance.collection('patients');
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(resizeToAvoidBottomInset: false,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(200, 70)),
                ),
                child: const Center(
                  child: Text(
                    'Doctor' "'" 's Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w300),
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 5),
                    child: Container(
                        height: screenwidth * 0.16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigoAccent,
                              blurRadius: 30,
                              offset: Offset(1, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(onChanged: (e){
                            Uname=e;
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
                              width: screenwidth * 0.16,
                              height: screenheight * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigoAccent,
                                    blurRadius: screenwidth * 0.1,
                                    offset:
                                        const Offset(1, 2), // Shadow position
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
                        height: screenwidth * 0.16,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigoAccent,
                              blurRadius: 30,
                              offset: Offset(5, 1), // Shadow position
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (e){
                              Upass=e;
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
                              width: screenwidth * 0.16,
                              height: screenheight * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.indigoAccent,
                                    blurRadius: screenwidth * 0.4,
                                    offset:
                                        const Offset(1, 2), // Shadow position
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
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                          textStyle: MaterialStatePropertyAll(
                              TextStyle(fontSize: screenwidth * 0.05))),
                      onPressed: () async {
                        User user = User(Uname, Upass);
                        print(Uname);
                       print(data.where('mail=$Uname'));
                        // if(Uname!='' && Upass!='')
                        // await SessionManager().set('patient', user);
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
                              builder: (context) => const DocRegister()),
                        );
                      },
                      child: const Text('Sign up'),
                    )
                  ],
                )
              ],
            )
          ]),
    );
  }
}
