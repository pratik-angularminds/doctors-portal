import 'package:flutter/material.dart';

class ViewAppointmentSingle extends StatefulWidget {
  final dynamic appointment;

  const ViewAppointmentSingle(this.appointment, {super.key});

  @override
  State<ViewAppointmentSingle> createState() => _ViewAppointmentSingleState();
}

class _ViewAppointmentSingleState extends State<ViewAppointmentSingle> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            title: const Text('Appointment')),
        body: ListView(
          children: [
            SizedBox(
              height: screenwidth/2,
                child: Image.asset('assets/Icons/doctor.png', alignment: Alignment.center)),
            ListTile(
              title: Text(widget.appointment['doctor']['name'],
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w400)),
              subtitle: Text(
                  'Status - ${widget.appointment['appoint']['status'] == 'Booked' ? widget.appointment['appoint']['status'] + ' Pending' : widget.appointment['appoint']['status']}'),
            ),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Icon(
                      Icons.call,
                      size: 25,
                      color: Color(0xFF3478A7),
                    )),
                Text('  ${widget.appointment['doctor']['contact']}')
              ],
            ),
        const SizedBox(
          height:10),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Icon(
                      Icons.mail,
                      size: 25,
                      color: Color(0xFF3478A7),
                    )),
                Text('  ${widget.appointment['doctor']['email']}')
              ],
            ),const SizedBox(
                height:10),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Icon(
                      Icons.add_location,
                      size: 25,
                      color: Color(0xFF3478A7),
                    )),
                Text('  ${widget.appointment['doctor']['address']}')
              ],
            ),const SizedBox(
                height:10),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Icon(
                      Icons.timer_sharp,
                      size: 25,
                      color: Color(0xFF3478A7),
                    )),
                Text('  ${widget.appointment['appoint']['timeFrom']}')
              ],
            ),const SizedBox(
                height:10),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Icon(
                      Icons.calendar_month,
                      size: 25,
                      color: Color(0xFF3478A7),
                    )),
                Text('  ${widget.appointment['appoint']['date']}')
              ],
            ),const SizedBox(
                height:10),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Icon(
                      Icons.star,
                      size: 25,
                      color: Color(0xFF3478A7),
                    )),
                Text('  ${widget.appointment['doctor']['speciality']}')
              ],
            )
          ],
        ));
  }
}
