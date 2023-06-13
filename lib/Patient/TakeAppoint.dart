import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_portal/tosters.dart';
import 'package:flutter/material.dart';

import '../Slot/Calender.dart';

class TakeAppoint extends StatefulWidget {
  const TakeAppoint({super.key});

  @override
  State<TakeAppoint> createState() => _TakeAppointState();
}

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Doctor Type'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class MultiRadio extends StatefulWidget {
  final List<String> items;

  const MultiRadio({Key? key, required this.items}) : super(key: key);

  @override
  State<MultiRadio> createState() => _MultiRadioState();
}

class _MultiRadioState extends State<MultiRadio> {
  dynamic _selectedItems = '';

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select your City!'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => ListTile(
                    onTap: () {
                      setState(() {
                        _selectedItems = item;
                      });
                    },
                    title: Text(item),
                    leading: Radio(
                      value: item,
                      groupValue: _selectedItems,
                      onChanged: (value) {},
                    ),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class _TakeAppointState extends State<TakeAppoint> {
  final CollectionReference doc =
      FirebaseFirestore.instance.collection('doctors');
  List doclist = [];
  String _selectedItems = '';
  List<String> _selectedcat = [];

  @override
  void initState() {
    super.initState();
    if (_selectedcat.isEmpty || _selectedItems.isEmpty) {
      getDocs();
    } else {
      getFilterDocs();
    }
  }

  getFilterDocs() async {
    QuerySnapshot querySnapshot;
    if (_selectedItems.isNotEmpty && _selectedcat.isEmpty) {
      querySnapshot = await doc.where('city', isEqualTo: _selectedItems).get();
    } else {
      querySnapshot = await doc
          .where('city', isEqualTo: _selectedItems)
          .where('speciality', whereIn: _selectedcat)
          .get();
    }
    setState(() {
      doclist = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  getDocs() async {
    QuerySnapshot querySnapshot = await doc.get();
    setState(() {
      doclist = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void _showMultiSelect() async {
    final List<String> items = [
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

    final String? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiRadio(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  void _showdoctorcat() async {
    final List<String> doctors = [
      'Internal medicine',
      'Pediatrics',
      'Surgery',
      'Family medicine',
      'Anesthesiology',
      'Dermatology',
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
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: doctors);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedcat = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget customSearchBar = const Text('Doctors List');
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    Widget cardTemplate(doctor) {
      return Card(
        color: Colors.white,
        child: Container(
          width: screenwidth,
          padding: const EdgeInsets.all(10),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
              children: [Wrap(children: [
              Image.asset(
                'assets/Icons/doctor.png',
                fit: BoxFit.cover,
                width: 90,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name'] ?? ' ',
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.greenAccent),
                      ),
                      Text(
                        doctor['speciality'] ?? ' ',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        doctor['email'] ?? ' ',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Wrap(children: [
                        SizedBox(
                            width: 160,
                            child: Text(
                              'Address: ${doctor['address']}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            )),
                      ]),
                    ],
                  ))),
            ]),
            Wrap(
                children: [TextButton(
              style: ButtonStyle(maximumSize: const MaterialStatePropertyAll(Size(200,100)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.indigoAccent),
                  textStyle:
                      const MaterialStatePropertyAll(TextStyle(fontSize: 12))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calender(doctor)),
                );
              },
              child: const Text('Take Appointment'),
            )])
          ]),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: customSearchBar,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       showSearch(context: context,
          //           delegate: CustomSearchDelegate()
          //       );
          //     },
          //     icon: customIcon,
          //   )
          // ],
          centerTitle: true,
        ),
        drawer: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: const Text(
              'Select Categories',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _showMultiSelect,
                    child: const Text('Select City'),
                  ),
                  const Divider(
                    height: 30,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Chip(
                        shadowColor: Colors.white,
                        label: Text(_selectedItems),
                        backgroundColor: _selectedItems.isNotEmpty
                            ? Colors.indigoAccent
                            : Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                      )),
                  const Divider(
                    height: 30,
                    color: Colors.white,
                  ),
                  ElevatedButton(
                    onPressed: _showdoctorcat,
                    child: const Text('Select Type of Doctor'),
                  ),
                  const Divider(
                    height: 30,
                  ),
                  Wrap(
                    children: _selectedcat
                        .map((e) => Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Chip(
                              label: Text(e),
                              backgroundColor: Colors.deepPurpleAccent,
                              labelStyle: const TextStyle(color: Colors.white),
                            )))
                        .toList(),
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.white,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 3,
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.redAccent)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                          flex: 3,
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.blueAccent)),
                            onPressed: () {
                              if (_selectedItems.isEmpty) {
                                return Toasters()
                                    .danger(context, 'Please Select the city');
                              }
                              getFilterDocs();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  )
                ],
              ))),
        ),
        backgroundColor: const Color(0xEDEDEDFF),
        body: ListView(
          children: doclist != []
              ? doclist.map((item) => cardTemplate(item)).toList()
              : [const Text('No list')],
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
