import 'dart:convert';
import 'dart:io';

import 'package:appoint_webapp/login_page.dart';
import 'package:appoint_webapp/secretary/schedule_appointment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../generated/l10n.dart';

class RegisterPatient extends StatelessWidget {
  final String SERVER_IP = "https://pz-backend2022.herokuapp.com/api";

  _registerPatient() async {
    var response = http.post(Uri.parse('$SERVER_IP/Patient/Register'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${user.token}"
        },
        body: jsonEncode({
          "name": _patientName.text,
          "surname": _patientSurname.text,
          "telephoneNumber": _phoneNumber.text
        }));
    print(response.then((value) => print(value.statusCode)));
    print(response.then((value) => print(value.reasonPhrase)));
  }

  TextEditingController _patientName = TextEditingController();
  TextEditingController _patientSurname = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          backgroundColor: Colors.teal,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: S.of(context).schedule,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: S.of(context).register,
            ),
          ],
          onTap: (option) {
            if (option == 0) {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleAppointment(
                            user: user,
                          )));
            }
          },
          selectedItemColor: Colors.white,
        ),
        appBar: AppBar(
          title: Text(
            S.of(context).registerPatient,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 90),
            Text(
              S.of(context).registerPatient,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            _buildTextField(S.of(context).name, _patientName),
            const SizedBox(height: 40),
            _buildTextField(S.of(context).surname, _patientSurname),
            const SizedBox(
              height: 40,
            ),
            _buildTextField(S.of(context).phoneNumber, _phoneNumber),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_patientName.text.isEmpty) {
                    _showMissingInputError(S.of(context).name, context);
                    return;
                  }
                  if (_patientSurname.text.isEmpty) {
                    _showMissingInputError(S.of(context).surname, context);
                    return;
                  }
                  if (_phoneNumber.text.isEmpty) {
                    _showMissingInputError(S.of(context).phoneNumber, context);
                    return;
                  }
                  _registerPatient();
                },
                child: Text(
                  S.of(context).register,
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))))
          ],
        )));
  }

  _buildTextField(String hintText, TextEditingController textController) {
    return SizedBox(
      width: 300,
      child: TextField(
          controller: textController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: hintText,
          )),
    );
  }

  _showMissingInputError(String missingInput, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  S.of(context).field +
                      missingInput +
                      S.of(context).isMissingPleaseFillIt,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.fromLTRB(80, 30, 80, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(50, 40)),
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
                  child: Text(S.of(context).ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ));
        });
  }
}
