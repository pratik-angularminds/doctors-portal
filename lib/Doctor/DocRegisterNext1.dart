import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/Doctor/DoctorLogin.dart';
import 'package:doctors_portal/tosters.dart';
import 'package:flutter/material.dart';
class DocRegisterNext1 extends StatefulWidget {
  var name='';
  var mail='';
  var pass='';
  DocRegisterNext1(this.name, this.mail, this.pass, {super.key});
  @override
  State<DocRegisterNext1> createState() => _DocRegisterNext1State();
}

class _DocRegisterNext1State extends State<DocRegisterNext1> {

  String name = '',
      mail = '',
      pass = '',
      add = '',
      city = 'Pune',
      deg = '',
      spec = 'Pediatrics',
      contact = '';
  var specialController = TextEditingController(text: 'Dentists');
  var cityController = TextEditingController(text: 'Pune');
  final CollectionReference doc =
      FirebaseFirestore.instance.collection('doctors');
  final specialEntries = [
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
  final cityEntries = [
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



  @override
  Widget build(BuildContext context) {
    Widget buildDropDown(controller, list,icon) {
      List<String> dup = <String>['One', 'Two', 'Three', 'Four'];
      controller.text=controller.text ?? dup[2];
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
            padding:  const EdgeInsets.fromLTRB(20, 0, 20, 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: DropdownButton(
                  alignment: Alignment.center,
                  icon: icon,
                  value: controller.text,
                  hint: const Text('Select Options'),
                  isExpanded: true,
                  underline: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.2),
                    ),
                  ),
                  items: list.isEmpty
                      ? dup.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : list,
                  onChanged: (value) {
                    setState(() {
                      controller.text = value;
                    });
                  },
                )),
      );
    }

    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xECECECFF),
      resizeToAvoidBottomInset: false,
      // 0xECECECFF
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_outline_rounded,
              size: 80,
              color: Colors.white,
            ),
            const Text('Doctor' "'" 's Registration',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  onChanged: (text) {
                    add = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter Address',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.location_on_outlined))),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            //   child: TextField(
            //       onChanged: (text) {
            //         city = text;
            //       },
            //       decoration: const InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(30)),
            //           borderSide: BorderSide.none,
            //         ),
            //         hintText: 'City',
            //         filled: true,
            //         fillColor: Colors.white,
            //         prefixIcon: Icon(Icons.location_city_rounded),
            //       )),
            // ),
            buildDropDown(cityController, cityEntries,const Icon(Icons.location_city_rounded)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                  onChanged: (text) {
                    deg = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Degree',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.my_library_books_outlined))),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: TextField(
            //       onChanged: (text) {
            //         spec = text;
            //       },
            //       decoration: const InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(30)),
            //             borderSide: BorderSide.none,
            //           ),
            //           hintText: 'Specialists',
            //           filled: true,
            //           fillColor: Colors.white,
            //           prefixIcon: Icon(Icons.favorite_border_rounded))),
            // ),
            buildDropDown(specialController,specialEntries,const Icon(Icons.favorite_border_rounded)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                  onChanged: (text) {
                    contact = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Contact',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.numbers))),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.indigoAccent),
                      maximumSize:
                          const MaterialStatePropertyAll(Size.square(100.0)),
                      fixedSize: const MaterialStatePropertyAll(Size(200, 55)),
                      textStyle: MaterialStatePropertyAll(
                          TextStyle(fontSize: screenwidth * 0.05))),
                  onPressed: () async {
                    if (widget.name != '' &&
                        widget.pass != '' &&
                        widget.mail != '' &&
                        add != '' &&
                        cityController.text != '' &&
                        deg != '' &&
                        specialController.text!='' &&
                        contact!='') {
                      QuerySnapshot querySnapshot1 = await doc.where('email',isEqualTo: widget.mail).get();
                      dynamic doctorlist =
                      querySnapshot1.docs.map((item) => item.data()).toList();
                      if(doctorlist.length==0){
                        await doc.add({
                          'name': widget.name,
                          'password': widget.pass,
                          'email': widget.mail,
                          'address': add,
                          'city': cityController.text,
                          'degree': deg,
                          'speciality': specialController.text,
                          'contact': contact
                        });
                        doc.snapshots();
                        Toasters().success(context, 'Signed Up Successfully');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorLogin()),
                        );
                      }
                      else{
                        print('asasd');
                        Toasters().danger(context, 'User Already Exists!!');
                      }
                    }
                    else{
                      Toasters().danger(context, 'All Fields are required!!');
                    }
                  },
                  child: const Text('Sign Up'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You don' "'" 't have an account ?',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  style: ButtonStyle(
                    textStyle:
                        const MaterialStatePropertyAll(TextStyle(fontSize: 16)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigoAccent),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorLogin()),
                    );
                  },
                  child: const Text('Sign In'),
                )
              ],
            )
          ],
        )
      ]),
    );
  }
}
