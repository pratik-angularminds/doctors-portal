import 'package:doctors_portal/Patient/TakeAppoint.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KindaCode.com',
      theme: ThemeData(
        // enable Material 3
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}

// Multi Select widget
// This widget is reusable
class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
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
      title: const Text('Select Topics'),
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _selectedItems = [];
  List<String> _selectedcat = [];

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

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Select Categories',
          style: TextStyle(color: Colors.deepPurpleAccent),
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
              Wrap(
                children: _selectedItems
                    .map((e) => Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Chip(
                          shadowColor: Colors.white,
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
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('cancel'),
                      )),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TakeAppoint()),
                          );
                        },
                        child: const Text('submit'),
                      ))
                ],
              )
            ],
          ))),
    );
  }
}
