import 'package:appoint_webapp/doctor/appointment_form.dart';
import 'package:appoint_webapp/model/AppointmentInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../model/Patient.dart';
import '../model/User.dart';
import 'appointment_archives.dart';
import 'list_of_appointments.dart';

class AppointmentStatistics extends StatelessWidget {
  late User user;
  late NewAppointment appointment;
  late bool archived;

  AppointmentStatistics(
      {Key? key,
      required this.appointment,
      required this.user,
      required this.archived})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
              case 1:
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentArchives(user: user)));
                break;
            }
          },
          selectedItemColor: Colors.white),
      appBar: AppBar(
        title: Text(
          S.of(context).patientStatistics,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Container(
        width: 300.0,
        height: MediaQuery.of(context).size.height * 0.7,
        margin: const EdgeInsets.all(16.0),
        child: ListView(
            padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
            children: _buildGeneralInformation(context)),
      )),
    );
  }

  _buildGeneralInformation(BuildContext context) {
    return [
      const SizedBox(
        height: 40,
      ),
      Text(
        S.of(context).generalInformation,
        style: const TextStyle(
            color: Colors.teal,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).nameForm,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(appointment.patientName, style: const TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).surnameForm,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(appointment.patientSurname,
              style: const TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).pesel,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text("98040705050", style: TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).phoneNumberForm,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(appointment.phoneNumber, style: const TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).visitDate,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(appointment.date, style: const TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).visitTime,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(appointment.time, style: const TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Text(
            S.of(context).isUrgent,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(S.of(context).no, style: const TextStyle(fontSize: 17)),
        ],
      ),
      const SizedBox(
        height: 60,
      ),
      !archived
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentForm(
                                  user: user,
                                  appointment:
                                      ArchivedAppointment.fromNewAppointment(
                                          appointment),
                                )));
                  },
                  child: Text(
                    S.of(context).appForm,
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(60, 60)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )))),
            )
          : Padding(
              padding: EdgeInsets.all(0),
            ),
      const SizedBox(
        height: 80,
      ),
    ];
  }
}
