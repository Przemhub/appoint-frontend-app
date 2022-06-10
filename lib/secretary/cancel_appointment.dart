import 'dart:convert';
import 'dart:io';

import 'package:appoint_webapp/secretary/register_patient.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../model/AppointmentSpot.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;

class CancelAppointment extends StatefulWidget {
  @override
  _CancelAppointment createState() => _CancelAppointment();
  late User user;
  late int patientId;
  late String patientName;

  CancelAppointment(
      {Key? key,
      required this.user,
      required this.patientId,
      required this.patientName})
      : super(key: key);
}

class _CancelAppointment extends State<CancelAppointment> {
  late Locale locale;
  static const String SERVER_IP = 'https://pz-backend2022.herokuapp.com/api';
  late User user;
  late String speciality = "Speciality";
  late int patientId;
  final TextEditingController patientName = TextEditingController();
  late List<AppointmentSpot> appointments;
  late int visitId;
  late String date;
  late String time;
  late String roomName;
  late String roomSpec;

  @override
  void initState() {
    user = widget.user;
    patientName.text = widget.patientName;
    patientId = widget.patientId;
    _initAppointments();
    super.initState();
  }

  _initAppointments() async {
    appointments = [];
    var res = await http.get(
        Uri.parse("$SERVER_IP/Patient/Appointments/$patientId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token});
    if (res.statusCode != 200) {
      print(res.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).errorGettingAppointments),
        duration: Duration(seconds: 1),
      ));
    } else {
      var jsonResponse = json.decode(res.body);
      for (var record in jsonResponse) {
        appointments.add(AppointmentSpot.filled(
            record["id"],
            record["date"].toString(),
            record["time"].toString(),
            record["roomNumber"].toString(),
            record["roomSpecialization"].toString()));
      }
    }
    setState(() {});
  }

  void removeAppointment(int id) {
    var response = http.delete(
      Uri.parse('$SERVER_IP/Appointment/Delete/$id'),
      headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token},
    );
    print(response.then((value) => value.statusCode == 204
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).visitRemovedSuccessfully),
            duration: Duration(seconds: 1),
          ))
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                S.of(context).errorRemovingVisit + value.statusCode.toString()),
            duration: Duration(seconds: 1),
          ))));
    _initAppointments();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    locale = Localizations.localeOf(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const biggerFont = TextStyle(fontSize: 18);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
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
              if (option == 1) {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPatient()));
              }
            },
            selectedItemColor: Colors.white),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            S.of(context).oncomingAppointments,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                  controller: patientName,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: S.of(context).patient2,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).appointments,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: appointments.length * 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      if (i.isOdd) return const Divider();
                      final index = i ~/ 2;
                      return Container(
                        key: Key(appointments[index].id.toString()),
                        child: ListTile(
                          leading: Column(children: [
                            Text(
                              appointments[index].date,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(appointments[index].time.substring(0, 5),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ]),
                          trailing: IconButton(
                              icon: Icon(Icons.delete_forever),
                              iconSize: 40,
                              onPressed: () {
                                visitId = appointments[index].id;
                                date = appointments[index].date;
                                time = appointments[index].time;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text(S.of(context).cancelAppointment),
                                      content: Text(S
                                              .of(context)
                                              .areYouSureYouWantToCancelAppointmentOn +
                                          "\n" +
                                          date +
                                          " " +
                                          time.substring(0, 5) +
                                          "?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            S.of(context).cancel,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              removeAppointment(visitId);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              S.of(context).accept,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                        const Size(100, 50)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )))),
                                      ],
                                    );
                                  },
                                );
                              }),
                          title: Column(
                            children: [
                              Text(
                                S.of(context).room +
                                    appointments[index].roomName,
                                style: biggerFont,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      );
                    }))
          ]),
        ));
  }
}
