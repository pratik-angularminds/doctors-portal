import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../tosters.dart';
import 'DoctorDashboard.dart';

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
  var specialController = TextEditingController(text: 'Dentists');
  var cityController = TextEditingController(text: 'Pune');
  final CollectionReference app =
      FirebaseFirestore.instance.collection('doctors');

  _DocEditProfileState() {
    loadData();
  }

  loadData() async {
    var id = await SessionManager().get('doctor');
    QuerySnapshot querySnapshot = await app.where('email', isEqualTo: id).get();
    setState(() {
      doctor = querySnapshot.docs.map((item) => item.data()).toList();
      name.text = doctor[0]['name'];
      email.text = doctor[0]['email'];
      contact.text = doctor[0]['contact'];
      cityController.text = doctor[0]['city'];
      specialController.text = doctor[0]['speciality'];
      address.text = doctor[0]['address'];
      degree.text = doctor[0]['degree'];
    });

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

  final specialEntries= [
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
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
  final cityEntries= [
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
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: const Text('Edit Profile'),
          actions: [
            TextButton(
                onPressed: () async {
                  var id = await getPatientID();
                  didChangeDependencies();
                  if (name.text.isNotEmpty &&
                      contact.text.isNotEmpty &&
                      email.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('doctors')
                        .doc(id)
                        .update({
                      'name': name.text,
                      'contact': contact.text,
                      'email': email.text,
                      'degree': degree.text,
                      'city': cityController.text,
                      'speciality': specialController.text,
                      'address': address.text,
                    }).then((value) {
                      Toasters()
                          .success(context, 'Profile Updated Successfully!!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorDashboard()),
                      );
                    });
                    SessionManager().set('doctor', email.text);
                    loadData();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
          centerTitle: true),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/Icons/doctor.png'),
                          )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", "", false, name),
              buildTextField("E-mail", "name@gmail.com", false, email),
              // buildTextField("Password", "********", true),
              buildDropDown(specialController, specialEntries),
              buildDropDown(cityController, cityEntries),
              buildTextField("Specialists", "TLV, Israel", false, contact),
              buildTextField("City", "TLV, Israel", false, degree),
              buildTextField("Location", "TLV, Israel", false, address),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropDown(controller, list) {
    List<String> dup = <String>['One', 'Two', 'Three', 'Four'];
    controller.text=controller.text ?? dup[2];
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: DropdownButton(
        value: controller.text,
        hint: const Text('Select Options'),
        isExpanded: true,
        underline: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
          ),
        ),
        items:list.isEmpty ?dup.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList():list,
        onChanged: (value) {
          setState(() {
            controller.text = value;
          });
        },
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, parameter) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: parameter,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
