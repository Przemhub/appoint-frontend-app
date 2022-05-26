import 'dart:convert';
import 'dart:io';

import 'package:appoint_webapp/doctor/appointment_archives.dart';
import 'package:appoint_webapp/doctor/appointments_statistics.dart';
import 'package:appoint_webapp/model/AppointmentInfo.dart';
import 'package:appoint_webapp/model/ScheduledNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../model/AppointmentList.dart';
import '../model/User.dart';

class ListOfAppointments extends StatefulWidget {
  late User user;

  @override
  _ListOfAppointmentsState createState() => _ListOfAppointmentsState();

  ListOfAppointments({Key? key, required this.user}) : super(key: key);
}

class _ListOfAppointmentsState extends State<ListOfAppointments> {
  int day = 0;
  final String SERVER_IP = 'https://pz-backend2022.herokuapp.com/api';
  late final AppointmentList _appointmentList = AppointmentList();
  late List _dayOfAppointment = _appointmentList.getDay(DateTime
      .now()
      .weekday);


  final List<String> _columnList = [
    "patientName",
    "patientSurname",
    "telephoneNumber",
    "date",
    "time"
  ];
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    initAppointmentList();

    // initNotification();

  }

  initNotification() async {
    DateTime now = DateTime.now();
    // String appointmentDate = _dayOfAppointment[0]["Date"];
    String appointmentDate =
    DateTime(now.year, now.month, now.day, now.hour, now.minute + 3)
        .toIso8601String();

    DateTime parsedDate = DateTime.parse(appointmentDate);
    NotificationAppLaunchDetails? details =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print(details?.didNotificationLaunchApp);
    String fullDate =
    _dayOfAppointment[0]["date"];
    String date = fullDate.substring(
        0, fullDate.indexOf("T"));
    String time = fullDate
        .substring(fullDate.indexOf("T") + 1,
        fullDate.indexOf("T") + 9);
    NewAppointment appointment = NewAppointment(
        patientName:
        _dayOfAppointment[0]
        ["patient"]["name"],
        patientSurname:
        _dayOfAppointment[0]
        ["patient"]["surname"],
        phoneNumber:
        _dayOfAppointment[0]
        ["patient"]["telephoneNumber"],
        date: date,
        time: time,
        length: _dayOfAppointment[0]
        ["length"],
        roomNumber: _dayOfAppointment[0]
        ["room"]["number"],
        roomSpecialization: _dayOfAppointment[0]
        ["room"]["specialization"],
        id: _dayOfAppointment[0]["id"]);
    ScheduledNotification startNotification = ScheduledNotification(
        id: 0,
        title: "Appointment started",
        body:
        "Your appointment on $date at $time has started!",
        payload: appointment.toString(),
        delay: ScheduledNotification.countDelayInMinutes(appointmentDate));
    startNotification.scheduleNotification();
    details =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    print(details?.didNotificationLaunchApp);
  }

  initAppointmentList() async {
    // await _getAppointmentList();
    _dayOfAppointment = _appointmentList.getDay(DateTime
        .now()
        .weekday);
    setState(() {});
  }

  Future<AppointmentList?> _getAppointmentList() async {
    // print("$SERVER_IP/Doctor/Appointments");
    // print("user token ${user.token}");
    var res = await http.get(
      Uri.parse("$SERVER_IP/Doctor/Appointments"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + user.token,
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
      },
    );
    print("getting appointment list");
    print(res.statusCode);
    // print(res.body);
    if (res.statusCode != 200) {
      print("Error");
      return null;
    } else {
      Map jsonResponse = json.decode(res.body);
      print("app list response:\n$jsonResponse");

      _appointmentList.setAppointmentMap(jsonResponse);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF5DB075),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'App. List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'App. History',
            ),
          ],
          onTap: (option) {
            switch (option) {
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
        backgroundColor: const Color(0xFF5DB075),
        title: const Text(
          "List Of Appointments",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: SizedBox(
            width: 200,
            child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: const Icon(Icons.calendar_today),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'dd/mm/yyyy',
                )),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: SizedBox(
            width: 200,
            child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(Icons.search),
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'name/surname',
                )),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: Container(
            width: 300,
            height: 37,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF5DB075), width: 2.0),
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            child: ListView.builder(
              itemCount: _appointmentList.length(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 1
                      ? const Color.fromARGB(161, 93, 176, 117)
                      : null,
                  child: InkWell(
                    onTap: () async {
                      switch (index) {
                        case 0:
                          _dayOfAppointment = _appointmentList.getMonday();
                          setState(() {});
                          break;
                        case 1:
                          _dayOfAppointment = _appointmentList.getTuesday();
                          setState(() {});
                          break;
                        case 2:
                          _dayOfAppointment = _appointmentList.getWednesday();
                          setState(() {});
                          break;
                        case 3:
                          _dayOfAppointment = _appointmentList.getThursday();
                          setState(() {});
                          break;
                        case 4:
                          _dayOfAppointment = _appointmentList.getFriday();
                          setState(() {});
                          break;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _appointmentList.getDays()[index],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Center(
          child: Container(
              width: 300.0,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 8,
                      offset: Offset(5, 5),
                      color: Color.fromRGBO(127, 140, 141, 0.5),
                      spreadRadius: 1)
                ],
                border: Border.all(color: Color(0xFF5DB075), width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index1) {
                    return Container(
                      color: index1 % 2 == 1
                          ? const Color.fromARGB(161, 93, 176, 117)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 80.0,
                          height: 200.0,
                          child: ListView.builder(
                              itemCount: _dayOfAppointment.length + 1,
                              itemBuilder: (context, index2) {
                                if (index2 == 0) {
                                  if (index1 == 0) {
                                    return const Center(
                                      child: SizedBox(
                                          height: 50,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    );
                                  } else if (index1 == 1) {
                                    return const Center(
                                      child: SizedBox(
                                          height: 50,
                                          child: Text("Surname",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold))),
                                    );
                                  } else if (index1 == 2) {
                                    return const Center(
                                      child: SizedBox(
                                          height: 50,
                                          child: Text("Phone number",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold))),
                                    );
                                  } else if (index1 == 3) {
                                    return const Center(
                                      child: SizedBox(
                                          height: 50,
                                          child: Text("Date",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold))),
                                    );
                                  } else {
                                    return const Center(
                                      child: SizedBox(
                                          height: 50,
                                          child: Text("Time",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold))),
                                    );
                                  }
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      NewAppointment appointment =
                                      NewAppointment(
                                          patientName:
                                          _dayOfAppointment[index2 - 1]
                                          ["patientName"],
                                          patientSurname:
                                          _dayOfAppointment[index2 - 1]
                                          ["patientSurname"],
                                          phoneNumber:
                                          _dayOfAppointment[index2 - 1]
                                          ["telephoneNumber"],
                                          date: _dayOfAppointment[index2 - 1]
                                          ["date"],
                                          time: _dayOfAppointment[index2 - 1]
                                          ["time"],
                                          length: _dayOfAppointment[index2 - 1]
                                          ["length"],
                                          roomNumber: _dayOfAppointment[index2 - 1]
                                          ["roomNumber"],
                                          roomSpecialization: _dayOfAppointment[index2 - 1]
                                          ["roomSpecialization"],
                                          id: _dayOfAppointment[index2 - 1]["id"]);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentStatistics(
                                                  appointment: appointment,
                                                  user: user,
                                                  archived: false,
                                                ),
                                          ));
                                    },
                                    child: Center(
                                      child: SizedBox(
                                          height: 35,
                                          child: Text(
                                              _dayOfAppointment[index2 - 1]
                                              [_columnList[index1]])),
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                    );
                  })),
        ),
      ],
    );
  }

  _buildTextField(String hintText) {
    return TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: hintText,
        ));
  }
}
