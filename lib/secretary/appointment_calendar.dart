import 'dart:convert';
import 'dart:io';

import 'package:appoint_webapp/model/AppointmentSpot.dart';
import 'package:appoint_webapp/secretary/register_patient.dart';
import 'package:appoint_webapp/secretary/schedule_appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../generated/l10n.dart';
import '../model/User.dart';
import 'package:http/http.dart' as http;

class AppointmentCalendar extends StatefulWidget {
  final String specialityInit;
  late User user;

  AppointmentCalendar(
      {Key? key, required this.specialityInit, required this.user})
      : super(key: key);

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  int selectedDuration = 0;
  late String language;
  static const String SERVER_IP = 'https://pz-backend2022.herokuapp.com/api';
  late String speciality = "Allergologist";
  late User user;
  late int roomId;
  late int doctorId;
  late String doctorName;
  late List<String> languages;
  late List<String> specialities = ["Allergologist"];
  late Locale locale;
  late List<AppointmentSpot> appointments;
  late List<AppointmentSpot> appointmentsAll;
  late Set<String> doctorList = {};
  late bool notFound = false;
  late String doctor = S.of(context).doctor;
  late List<String> dropdownDoctor = [S.of(context).doctor];
  DateTime dateToday = DateTime.now();
  DateTime tempDate = DateTime.now();
  final TextEditingController date = TextEditingController();

  final languageDictionaryPL = {
    "Polish": "Polski",
    "English": "Angielski",
    "Ukrainian": "Ukraiński",
    "Russian": "Rosysjki",
    "German": "Niemiecki"
  };
  final specialityDictionaryPL = {
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
    speciality = widget.specialityInit;
    language = "Polski";
    date.text = DateTime.now().toString().substring(0, 10);
    _initLanguages();
    _initSpecialities();
    _initAppointments();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    locale = Localizations.localeOf(context);
    super.didChangeDependencies();
  }

  _initAppointments() async {
    appointments = [];
    doctorList = {};
    appointmentsAll = [];
    var spec;
    if (locale.toString() == "pl") {
      spec = specialityDictionaryPL.keys
          .firstWhere((k) => specialityDictionaryPL[k] == speciality);
    } else {
      spec = speciality;
    }
    var lang;
    if (locale.toString() == "pl") {
      lang = languageDictionaryPL.keys
          .firstWhere((k) => languageDictionaryPL[k] == language);
    } else {
      lang = speciality;
    }
    String tempDate = date.text;
    var res = await http.get(
        Uri.parse(
            "$SERVER_IP/Appointment/GetPossibleTerms?Specialization=$spec&date=$tempDate&Length=60&Language=$lang"),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token});
    if (res.statusCode != 200) {
      print(res.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).noAppointmentSlotsOnThisDay),
        duration: Duration(seconds: 1),
      ));
    } else {
      Map<String, dynamic> jsonResponse = json.decode(res.body);
      print(jsonResponse);
      for (var record in jsonResponse["terms"]) {
        appointmentsAll.add(AppointmentSpot(
            date: record["date"].toString().substring(0, 10),
            time: record["date"].toString().substring(11, 16),
            doctorName: record["doctorName"].toString(),
            doctorId: record["doctorId"],
            roomId: record["roomId"],
            roomName: record["roomNumber"].toString()));
        doctorList.add(record["doctorName"]);
      }
    }
    appointments.addAll(appointmentsAll);
    dropdownDoctor = [S.of(context).doctor];
    dropdownDoctor.addAll(doctorList);
    setState(() {});
  }

  _initLanguages() async {
    languages = [];
    var res = await http.get(Uri.parse("$SERVER_IP/Language/GetAll"),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token});
    doctor = S.of(context).doctor;
    if (res.statusCode != 200) {
      print("Error");
    } else {
      var jsonResponse = json.decode(res.body);
      for (var record in jsonResponse) {
        if (locale.toString() == "pl" &&
            languageDictionaryPL.containsKey(record["name"])) {
          String temp = languageDictionaryPL[record["name"]].toString();
          languages.add(temp);
        } else {
          languages.add(record["name"].toString());
        }
        language = languages[0];
      }
    }
    _initAppointments();
    setState(() {});
  }

  _initSpecialities() async {
    specialities = [];
    var res = await http.get(Uri.parse("$SERVER_IP/Specialization/GetAll"),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + user.token});
    if (res.statusCode != 200) {
      print("Error");
    } else {
      var jsonResponse = json.decode(res.body);
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

  void _showLanguageDialog() async {
    final String? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LanguageCheckBox(items: languages, language: language);
      },
    );
    if (results != null) {
      setState(() {
        language = results;
        _initAppointments();
      });
    }
  }

  void showAppointmentDialog(
      String date, String time, String doctor, String room) async {
    final String? res = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppointmentView(
          date: date,
          time: time,
          doctor: doctor,
          room: room,
        );
      },
    );
    int len = 20;
    if (res != null) {
      switch (res) {
        case "20min":
          len = 20;
          break;
        case "40min":
          len = 40;
          break;
        case "60min":
          len = 60;
          break;
      }
      setState(() {
        Navigator.pop(context, {
          "date": date,
          "time": time,
          "doctor": doctorId,
          "doctorName": doctorName,
          "duration": len,
          "room": roomId
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const biggerFont = TextStyle(fontSize: 18);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          S.of(context).scheduleAppointment,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.teal),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              _initAppointments();
                            });
                          },
                          items: specialities.map((item) {
                            return DropdownMenuItem(
                                value: item, child: Center(child: Text(item)));
                          }).toList(),
                          underline: Container(),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.teal),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.badge,
                          color: Colors.teal,
                        ),
                        DropdownButton<String>(
                          value: doctor,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconEnabledColor: Colors.teal,
                          iconDisabledColor: Colors.black26,
                          borderRadius: BorderRadius.circular(20.0),
                          elevation: 16,
                          style:
                              const TextStyle(color: Colors.teal, fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              doctor = value.toString();
                              if (doctor != S.of(context).doctor)
                                appointments = [];
                              for (var i in appointmentsAll) {
                                if (i.doctorName == doctor) {
                                  appointments.add(i);
                                }
                              }
                            });
                          },
                          items: dropdownDoctor.map((item) {
                            return DropdownMenuItem(
                                value: item, child: Center(child: Text(item)));
                          }).toList(),
                          underline: Container(),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _showLanguageDialog,
                  icon: const Icon(Icons.language),
                  color: Colors.teal,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                      enabled: false,
                      controller: date,
                      style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 25),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "yyyy-mm-dd",
                      )),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (dateToday.isAfter(DateTime.now())) {
                        dateToday = dateToday.subtract(const Duration(days: 1));
                        date.text = dateToday.toString().substring(0, 10);
                        _initAppointments();
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.teal,
                  splashColor: const Color(0x779AFFD0),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      dateToday = dateToday.add(const Duration(days: 1));
                      date.text = dateToday.toString().substring(0, 10);
                      _initAppointments();
                    });
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.teal,
                  splashColor: const Color(0x779AFFD0),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: appointments.length * 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: /*1*/ (context, i) {
                      if (i.isOdd) return const Divider();
                      final index = i ~/ 2;
                      return Container(
                        key: Key(appointments[index].doctorName),
                        child: ListTile(
                          leading: Text(appointments[index].time),
                          trailing: Text(S.of(context).room +
                              appointments[index].roomName),
                          title: Text(
                            appointments[index].doctorName,
                            style: biggerFont,
                          ),
                          onTap: () {
                            doctorName = appointments[index].doctorName;
                            doctorId = appointments[index].doctorId;
                            roomId = appointments[index].roomId;
                            showAppointmentDialog(
                                date.text,
                                appointments[index].time,
                                appointments[index].doctorName,
                                appointments[index].roomName);
                            setState(() {});
                          },
                        ),
                      );
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return SimpleDialog(
                    title: Text(S.of(context).chooseDate),
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.height * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: TableCalendar(
                            focusedDay: tempDate,
                            firstDay: DateTime.now(),
                            lastDay: DateTime(2050),
                            daysOfWeekStyle: const DaysOfWeekStyle(
                              weekendStyle: TextStyle(color: Colors.grey),
                            ),
                            calendarStyle: const CalendarStyle(
                              weekendTextStyle: TextStyle(color: Colors.grey),
                              todayDecoration: BoxDecoration(
                                color: Colors.blueGrey,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Colors.teal,
                                shape: BoxShape.circle,
                              ),
                            ),
                            selectedDayPredicate: (currentSelectedDate) {
                              return (isSameDay(tempDate, currentSelectedDate));
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              if (!isSameDay(tempDate, selectedDay)) {
                                setState(() {
                                  tempDate = selectedDay;
                                  tempDate = focusedDay;
                                });
                              }
                            },
                            calendarFormat: CalendarFormat.month,
                            weekendDays: const [DateTime.sunday],
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekHeight:
                                MediaQuery.of(context).size.height * 0.05,
                            rowHeight:
                                MediaQuery.of(context).size.height * 0.06),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.of(context).cancel)),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.of(context).ok)),
                        ],
                      )
                    ],
                  );
                });
              }).then((_) {
            setState(() {
              dateToday = tempDate;
              date.text = dateToday.toString().substring(0, 10);
              _initAppointments();
            });
          })
        },
        tooltip: 'Increment',
        child: const Icon(Icons.calendar_month),
      ),
    );
  }
}

class LanguageCheckBox extends StatefulWidget {
  final List<String> items;
  final String language;

  LanguageCheckBox({Key? key, required this.items, required this.language})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LanguageDialog();
}

class _LanguageDialog extends State<LanguageCheckBox> {
  late String selected;

  @override
  void initState() {
    selected = widget.language;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).selectLanguage),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map(
                (item) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(item),
                    Radio(
                      value: item.toString(),
                      onChanged: (value) => {
                        setState(() {
                          selected = value.toString();
                        })
                      },
                      groupValue: selected,
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.pop(context, widget.language);
          },
        ),
        ElevatedButton(
          child: Text(S.of(context).submit),
          onPressed: () {
            Navigator.pop(context, selected);
          },
        ),
      ],
    );
  }
}

class AppointmentView extends StatefulWidget {
  final String date;
  final String time;
  final String doctor;
  final String room;

  const AppointmentView(
      {Key? key,
      required this.date,
      required this.time,
      required this.doctor,
      required this.room})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppointmentDialog();
}

class _AppointmentDialog extends State<AppointmentView> {
  String selectedDuration = "20min";
  List<String> durationList = ["20min", "40min", "60min"];
  static const boldFont = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).confirmDate),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).date,
            style: boldFont,
          ),
          Text(widget.date),
          Text(
            S.of(context).time,
            style: boldFont,
          ),
          Text(widget.time),
          Text(
            S.of(context).doctor,
            style: boldFont,
          ),
          Text(widget.doctor),
          Text(
            S.of(context).room,
            style: boldFont,
          ),
          Text(widget.room),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                  selected: selectedDuration == "20min",
                  label: Text("20min"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.teal,
                  selectedColor: Colors.lime,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedDuration = "20min";
                      }
                    });
                  }),
              ChoiceChip(
                  selected: selectedDuration == "40min",
                  label: Text("40min"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.teal,
                  selectedColor: Colors.lime,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedDuration = "40min";
                      }
                    });
                  }),
              ChoiceChip(
                  selected: selectedDuration == "60min",
                  label: Text("60min"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: Colors.teal,
                  selectedColor: Colors.lime,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedDuration = "60min";
                      }
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(S.of(context).cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text(S.of(context).submit),
                onPressed: () {
                  Navigator.pop(context, selectedDuration);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
