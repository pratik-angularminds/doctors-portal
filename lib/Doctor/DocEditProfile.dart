import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../tosters.dart';

class DocEditProfile extends StatefulWidget {
  const DocEditProfile({Key? key}) : super(key: key);

  @override
  State<DocEditProfile> createState() => _DocEditProfileState();
}

class _DocEditProfileState extends State<DocEditProfile> {
  List doctor = [];
  var name = TextEditingController();
  var email = TextEditingController();
  var contact = TextEditingController();
  var degree = TextEditingController();
  var address = TextEditingController();
  var specialController = TextEditingController();
  var cityController = TextEditingController();
  final CollectionReference app =
      FirebaseFirestore.instance.collection('doctors');
  final GlobalKey _dropdown1key= GlobalKey();
  final GlobalKey _dropdown2key= GlobalKey();
  _DocEditProfileState() {
    loadData();
  }

  loadData() async {
    var id = await SessionManager().get('doctor');
    QuerySnapshot querySnapshot = await app.where('email', isEqualTo: id).get();
    setState(() {
      doctor = querySnapshot.docs.map((item) => item.data()).toList();
    });
    name.text = doctor[0]['name'];
    email.text = doctor[0]['email'];
    contact.text = doctor[0]['contact'];
    cityController.text = doctor[0]['city'];
    specialController.text = doctor[0]['speciality'];
    address.text = doctor[0]['address'];
    degree.text = doctor[0]['degree'];
  }

  Future<String> getPatientID() async {
    final CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors');
    QuerySnapshot querySnapshot1 = await doctors.get();
    dynamic doctorlist =
        querySnapshot1.docs.map((item) => item.data()).toList();
    dynamic count = 0;
    int c = -1;
    final pmail = doctor.isNotEmpty ? doctor[0]['email'] : '';
    doctorlist
        .map((item) => item['email'] == pmail ? c = count : count++)
        .toList();
    dynamic idSarray = querySnapshot1.docs.map((item) => item.id).toList();
    return idSarray[c];
  }

  final List<String> special = [
    'Internal medicine',
    'Pediatrics',
    'Surgery',
    'Family medicine',
    'Anesthesiology',
    'Dermatology',
    'Gynesian',
    'Obstetrics and gynaecology',
    'Orthopedics',
    'Emergency medicine',
    'Ophthalmology',
    'Dentists',
    'Psychiatry',
    'General surgery',
    'Otorhinolaryngology',
    'Neurology',
    'Urology',
    'Physical therapy',
    'Oncology',
    'Pathology',
    'Immunology',
    'Plastic surgery',
    'Nuclear medicine',
    'Cardiology',
    'Neurosurgery',
    'Pulmonology',
    'Cardio-thoracic surgery',
    'Radiology',
    'Gastroenterology',
    'Rheumatology',
    'Geriatrics',
    'Intensive care medicine',
    'Endocrinology',
    'Medical genetics',
    'Preventive healthcare',
    'Nephrology',
    'Diagnostic Radiology',
    'Hematology',
    'Occupational medicine',
    'Vascular surgery',
    'Public health',
    'Clinical chemistry',
    'Pain management',
    'Sports medicine',
    'Child and adolescent psychiatry',
    'Clinical pathology',
    'Forensic pathology',
    'Pediatric Hematology Oncology',
    'Pediatric surgery',
    'Neonatology',
    'Hospital medicine',
    'Neuroradiology',
    'Pediatric cardiology'
  ];
  final List<String> City = [
    'Ahmednagar',
    'Akola',
    'Amravati',
    'Aurangabad',
    'Bhandara',
    'Beed',
    'Buldhana',
    'Chandrapur',
    'Dhule',
    'Gadchiroli',
    'Gondia',
    'Hingoli',
    'Jalgaon',
    'Jalna',
    'Kolhapur',
    'Latur',
    'Mumbai City',
    'Mumbai suburban',
    'Nandurbar',
    'Nanded',
    'Nagpur',
    'Nashik',
    'Osmanabad',
    'Parbhani',
    'Pune',
    'Raigad',
    'Ratnagiri',
    'Sindhudurg',
    'Sangli',
    'Solapur',
    'Satara',
    'Thane',
    'Wardha',
    'Washim',
    'Yavatmal',
  ];
  String selectedColor = '';
  String selectedCity = '';
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    final List<DropdownMenuEntry> colorEntries = <DropdownMenuEntry>[];
    for (final spec in special) {
      colorEntries
          .add(DropdownMenuEntry(value: spec, label: spec, enabled: true));
    }
    final List<DropdownMenuEntry> cityEntries = <DropdownMenuEntry>[];
    for (final city in City) {
      cityEntries
          .add(DropdownMenuEntry(value: city, label: city, enabled: true));
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: const Text('Edit Profile'),
          actions: [
            TextButton(
                onPressed: () async {
                  // var id = await getPatientID();print(name.text);
                  // didChangeDependencies();
                  // if (name.text.isNotEmpty &&
                  //     contact.text.isNotEmpty &&
                  //     email.text.isNotEmpty) {
                  //   FirebaseFirestore.instance
                  //       .collection('doctors')
                  //       .doc(id)
                  //       .update({
                  //     'name': name.text,
                  //     'contact': contact.text,
                  //     'email': email.text,
                  //     'degree':degree.text,
                  //     'city':cityController.text,
                  //     'speciality': specialController.text,
                  //     'address':address.text,
                  //   }).then((value) {
                  //     Toasters()
                  //         .success(context, 'Profile Updated Successfully!!');
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const DoctorDashboard()),
                  //     );
                  //   });
                  //   SessionManager().set('doctor', email.text);
                  //   loadData();
                  // }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: screenheight * 0.2,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.orangeAccent,
                          Colors.red,
                          Colors.redAccent
                          //add more colors for gradient
                        ],
                        begin: Alignment.topLeft, //begin of the gradient color
                        end: Alignment.bottomRight, //end of the gradient color
                        stops: [0, 0.2, 0.5, 0.8]),
                    color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Container(
                        width: 60,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.person, size: 30),
                          color: Colors.indigoAccent,
                          onPressed: () {},
                        ),
                      ),
                      title: Text(
                        doctor.isEmpty ? '' : doctor[0]['name'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      subtitle: const Text(
                        'Online',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    children: [
                      TextField(
                          controller: name,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.indigoAccent),
                              ),
                              label: Text(
                                'NAME',
                                style: TextStyle(color: Colors.grey),
                              ))),
                      TextField(
                          controller: email,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.indigoAccent),
                              ),
                              label: Text(
                                'E-MAIL',
                                style: TextStyle(color: Colors.grey),
                              ))),
                      TextField(
                          controller: contact,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 2, color: Colors.indigoAccent),
                              ),
                              label: Text(
                                'CONTACT',
                                style: TextStyle(color: Colors.grey),
                              ))),
                      Wrap(children: [
                        DropdownMenu(key:_dropdown2key,
                          inputDecorationTheme: const InputDecorationTheme(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                          initialSelection: doctor.isNotEmpty?doctor[0]['city']:'',
                          label: const Text(
                            'CITY',
                            style: TextStyle(color: Colors.grey),
                          ),
                          dropdownMenuEntries: cityEntries,
                          onSelected: (c) {
                            setState(() {
                              selectedCity = c;
                            });
                          },
                        ),
                        DropdownMenu(key: _dropdown1key,
                          inputDecorationTheme: const InputDecorationTheme(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                          initialSelection:doctor.isNotEmpty?doctor[0]['speciality']:'',
                          label: const Text(
                            'SPECIALISTS',
                            style: TextStyle(color: Colors.grey),
                          ),
                          dropdownMenuEntries: colorEntries,
                          onSelected: (color) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                      ],),
                      TextField(
                          controller: degree,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 2, color: Colors.indigoAccent),
                              ),
                              label: Text(
                                'DEGREE',
                                style: TextStyle(color: Colors.grey),
                              ))),
                      TextField(
                          controller: address,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(
                                    width: 2, color: Colors.indigoAccent),
                              ),
                              label: Text(
                                'ADDRESS',
                                style: TextStyle(color: Colors.grey),
                              ))),
                      // TextField(
                      //     controller: contact,
                      //     decoration: const InputDecoration(
                      //         enabledBorder: UnderlineInputBorder(
                      //           //<-- SEE HERE
                      //           borderSide: BorderSide(
                      //               width: 2, color: Colors.indigoAccent),
                      //         ),
                      //         label: Text(
                      //           'SPECIALITY',
                      //           style: TextStyle(color: Colors.grey),
                      //         ))),

                    ],
                  )))
        ],
      ),
    );
  }
}
