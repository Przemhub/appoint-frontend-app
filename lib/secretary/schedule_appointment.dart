import 'dart:convert';
import 'dart:io';

import 'package:appoint_webapp/secretary/cancel_appointment.dart';
import 'package:appoint_webapp/secretary/register_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../generated/l10n.dart';
import '../model/Patient.dart';
import '../model/User.dart';
import 'appointment_calendar.dart';

class ScheduleAppointment extends StatefulWidget {
  late User user;

  @override
  _ScheduleAppointment createState() => _ScheduleAppointment();

  ScheduleAppointment({Key? key, required this.user}) : super(key: key);
}

class _ScheduleAppointment extends State<ScheduleAppointment> {
  int chosenRecord = 9999;
  static const String SERVER_IP = 'https://pz-backend2022.herokuapp.com/api';
  late User user;
  late List<Patient> _patientList;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  late int doctorId = -1;
  late int roomId;
  late int duration;
  late Locale locale;
  late TextEditingController patientName = TextEditingController();
  late TextEditingController doctorName = TextEditingController();
  late Map<String, String> appointment;
  late Map<String, String> closestDate;
  late List<String> specialities;
  String speciality = "Speciality";
  final specialityDictionaryPL = {
    "Speciality": "Specalizacja",
    "Allergologist": "Alergolog",
    "Anesthesiologist": "Anestezjolog",
    "Dermatologist": "Dermatolog",
    "Radiologist": "Radiolog",
    "Family doctor": "Lekarz rodzinny",
    "Internist": "Internista",
    "Neurologist": "Neurolog",
    "Gynecologist": "Ginekolog",
    "Pediatrist": "Pediatra",
    "Rehabilitation": "Rehabilitacja",
    "Psychiatrist": "Psychiatra",
    "Oncologist": "Onkolog",
    "Surgeon": "Chirurg",
    "Urologist": "Urolog",
    "Cardiologist": "Kardiolog"
  };

  @override
  void initState() {
    user = widget.user;
    _patientList = [];
    _getPatientList();
    _initSpecialities();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    locale = Localizations.localeOf(context);
    super.didChangeDependencies();
  }

  _getPatientList() async {
    print("$SERVER_IP/Doctor/Appointments");
    var res = await http.get(Uri.parse("$SERVER_IP/Registrator/Patients"),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token});
    print(res.body);
    if (res.statusCode != 200) {
      print("Error");
    } else {
      var jsonResponse = json.decode(res.body);
      print(jsonResponse);

      for (var record in jsonResponse) {
        _patientList.add(Patient.Id(record["id"], record["name"],
            record["surname"], record["telephoneNumber"]));
      }
      setState(() {});
    }
  }

  _initSpecialities() async {
    specialities = [];
    var res = await http.get(Uri.parse("$SERVER_IP/Specialization/GetAll"),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token});
    if (locale.toString() == "pl") {
      specialities.add(specialityDictionaryPL["Speciality"].toString());
    } else {
      specialities.add("Speciality");
    }
    print(res.body);
    if (res.statusCode != 200) {
      print("Error");
    } else {
      var jsonResponse = json.decode(res.body);
      print(jsonResponse);
      for (var record in jsonResponse) {
        if (locale.toString() == "pl" &&
            specialityDictionaryPL.containsKey(record["name"])) {
          String temp = specialityDictionaryPL[record["name"]].toString();
          specialities.add(temp);
        } else {
          specialities.add(record["name"].toString());
        }
      }
      speciality = specialities[0];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String SERVER_IP = "https://pz-backend2022.herokuapp.com/api";

    registerAppointment() async {
      var tmp = jsonEncode({
        "date": "${_dateController.text}T${_timeController.text}:00.000Z",
        "length": duration,
        "patientId": _patientList[chosenRecord].id,
        "userId": doctorId,
        "roomId": roomId
      });
      var response = http.post(Uri.parse('$SERVER_IP/Appointment/Register'),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
            HttpHeaders.acceptCharsetHeader: "*/*",
            HttpHeaders.authorizationHeader: "Bearer " + user.token
          },
          body: tmp);

      print(tmp);
      print(_patientList[chosenRecord].id);
      print(duration);
      print("${_dateController.text}T${_timeController.text}.000Z");
      print(response.then((value) => value.statusCode == 200
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(S.of(context).visitSavedSuccessfully),
              duration: Duration(seconds: 1),
            ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(S.of(context).errorSavingVisit),
              duration: Duration(seconds: 1),
            ))));
      _dateController.text="";
      _timeController.text="";
      patientName.text="";
      doctorName.text="";
      doctorId=-1;
    }

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
            S.of(context).scheduleAppointment,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                            enabled: false,
                            controller: _dateController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.calendar_today),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: "yyyy-mm-dd",
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                            controller: _timeController,
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.watch),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: "hh:mm:ss",
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
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
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                          controller: doctorName,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.medical_information),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            hintText: S.of(context).doctor2,
                          )),
                    )
                  ],
                ),
              ]),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.teal),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.vaccines,
                        color: Colors.teal,
                      ),
                      DropdownButton<String>(
                        value: speciality,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.teal,
                        iconDisabledColor: Colors.black26,
                        borderRadius: BorderRadius.circular(20.0),
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.teal, fontSize: 20),
                        onChanged: (value) {
                          setState(() {
                            speciality = value.toString();
                          });
                        },
                        items: specialities.map((item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        underline: Container(),
                      ),
                    ],
                  )),
              ElevatedButton(
                onPressed: () async {
                  if (speciality != specialities[0]) {
                    final calendarResult = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentCalendar(
                                  specialityInit: speciality,
                                  user: user,
                                )));
                    setState(() {
                      _timeController.text = calendarResult["time"];
                      _dateController.text = calendarResult["date"];
                      doctorId = calendarResult["doctor"];
                      doctorName.text = calendarResult["doctorName"];
                      roomId = calendarResult["room"];
                      duration = calendarResult["duration"];
                      print(calendarResult);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).pleaseChooseSpeciality),
                    ));
                  }
                },
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(60, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                child: Icon(Icons.calendar_today_rounded),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (chosenRecord == 9999 || doctorId == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            S.of(context).pleaseChooseAppointmentAndPatient),
                      ));
                    } else {
                      registerAppointment();
                    }
                  },
                  child: Text(
                    S.of(context).appointSchedule,
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )))),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Text(
              S.of(context).patientList,
              style: const TextStyle(
                  color: Color(0xFF424242),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: _buildTextField(S.of(context).namesurname),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
                width: 300.0,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 8,
                        offset: Offset(5, 5),
                        color: Color.fromRGBO(127, 140, 141, 0.5),
                        spreadRadius: 1)
                  ],
                  border: Border.all(color: Colors.teal, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    itemCount: _patientList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _patientList.length) {
                        return _buildRecord(
                            "${_patientList[index].name} ${_patientList[index].surname}",
                            _patientList[index].telephoneNumber,
                            index);
                      } else {
                        return _buildAddPatient(context, index);
                      }
                    })),
          ),
        ]));
  }

  _buildRecord(String name, String number, int index) {
    return InkWell(
      onTap: () {
        if (chosenRecord == index) {
          chosenRecord = 9999;
          patientName.text = "";
        } else {
          chosenRecord = index;
          patientName.text = _patientList[chosenRecord].name +
              "\n" +
              _patientList[chosenRecord].surname;
        }
        setState(() {});
      },
      child: Container(
          width: 400,
          height: 80,
          decoration: BoxDecoration(
              color: chosenRecord == index
                  ? Colors.teal
                  : index % 2 == 1
                      ? Color(0x5B6ACDB6)
                      : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: chosenRecord == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              S.of(context).tel + number,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: chosenRecord == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (chosenRecord == index) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CancelAppointment(
                                                  patientId:
                                                      _patientList[chosenRecord]
                                                          .id,
                                                  patientName: _patientList[
                                                              chosenRecord]
                                                          .name +
                                                      " " +
                                                      _patientList[chosenRecord]
                                                          .surname,
                                                  user: user,
                                                )));
                                  } else {
                                    return null;
                                  }
                                },
                                icon: Icon(Icons.history),
                                iconSize: 30,
                                color: chosenRecord == index
                                    ? Colors.white
                                    : index % 2 == 1
                                        ? Color(0xA6ACDB6)
                                        : Colors.white),
                          ],
                        ),
                      ]),
                ],
              ),
            ],
          )),
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

  Widget _buildAddPatient(context, index) {
    return InkWell(
      key: const Key("add patient ink"),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegisterPatient()));
      },
      child: Container(
        decoration:
            BoxDecoration(color: index % 2 == 1 ? Color(0x9034A386) : null),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 15, 0, 15),
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 30,
              ),
              Text(
                S.of(context).addPatient,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
