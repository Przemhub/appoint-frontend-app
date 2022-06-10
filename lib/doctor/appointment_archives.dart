import 'package:appoint_webapp/doctor/appointments_statistics.dart';
import 'package:appoint_webapp/model/AppointmentInfo.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../model/User.dart';
import 'arch_appointment_statistics.dart';
import 'list_of_appointments.dart';

class AppointmentArchives extends StatelessWidget {
  late User user;

  AppointmentArchives({Key? key, required this.user}) : super(key: key);
  List<ArchivedAppointment> archivedAppointments = [
    ArchivedAppointment("Jan", "Kowalski", "26:01:2021", "success")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          backgroundColor: Colors.teal,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: S.of(context).appList,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: S.of(context).appHistory,
            ),
          ],
          onTap: (option) {
            switch (option) {
              case 0:
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOfAppointments(user: user)));
                break;
            }
          },
          selectedItemColor: Colors.white),
      appBar: AppBar(

        title: Text(
          S.of(context).appointmentHistory,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
        child: SizedBox(
          width: 350.0,
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView(
              padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
              children: [
                for (var archApp in archivedAppointments)
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ArchAppointmentStatistics(
                        //         appointment: appointment,
                        //         user: user,
                        //         archived: true,
                        //       ),
                        //     ));
                      },
                      child: _buildArchivedVisit(archApp, context))
              ]),
        ),
      )),
    );
  }

  _buildArchivedVisit(
      ArchivedAppointment archivedAppointment, BuildContext context) {
    return Container(
      width: 300.0,
      height: 150.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(5, 5),
              color: Color.fromRGBO(127, 140, 141, 0.5),
              spreadRadius: 1)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).patientName,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                    "${archivedAppointment.patientName} ${archivedAppointment.patientSurname}",
                    style: TextStyle(fontSize: 17))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  S.of(context).appDate,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(archivedAppointment.date, style: TextStyle(fontSize: 17))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  S.of(context).appStatus,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(archivedAppointment.status,
                    style: TextStyle(
                        fontSize: 17,
                        color: _determineStatusTextColor(
                            archivedAppointment.status)))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _determineStatusTextColor(String status) {
    switch (status) {
      case "success":
        return Colors.green;
      case "fail":
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
