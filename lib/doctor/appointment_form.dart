import 'package:appoint_webapp/doctor/list_of_appointments.dart';
import 'package:appoint_webapp/model/AppointmentInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../model/Medicine.dart';
import '../model/User.dart';
import 'appointment_archives.dart';

class AppointmentForm extends StatefulWidget {
  late User user;
  late ArchivedAppointment appointment;

  @override
  _AppointmentFormState createState() => _AppointmentFormState();

  AppointmentForm({Key? key, required this.user, required this.appointment})
      : super(key: key);
}

class _AppointmentFormState extends State<AppointmentForm> {
  late List<Medicine> medicineList = [
    Medicine.withoutId(
        doses: 0,
        name: "lek",
        remarks: "remarks",
        prescriptionDate: "prescriptionDate",
        schedule: "",
        unit: ""),
    Medicine.withoutId(
        doses: 0,
        name: "lek2",
        remarks: "remarks",
        prescriptionDate: "prescriptionDate",
        schedule: "",
        unit: "")
  ];
  late List<Medicine> chosenMedicineList = [];
  late List<TextEditingController> dosageList = [];
  late List<String> unitList = [];
  late List<String> scheduleList = [];
  late User user;

  final TextEditingController _visitRemarksController = TextEditingController();

  final TextEditingController _patientRemarksController =
      TextEditingController();

  final TextEditingController _medicineNameController = TextEditingController();

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int itemsCount = medicineList.length > chosenMedicineList.length
        ? medicineList.length
        : chosenMedicineList.length;
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
                          builder: (context) =>
                              ListOfAppointments(user: user)));
                  break;
                case 1:
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AppointmentArchives(user: user)));
                  break;
              }
            },
            selectedItemColor: Colors.white),
        appBar: AppBar(

          title: Text(
            S.of(context).appointmentForm,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
            child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                  child: Text(
                    S.of(context).appointmentForm,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).nameForm,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(widget.appointment.patientName)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).surnameForm,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(widget.appointment.patientSurname)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).phoneNumberForm,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(widget.appointment.phoneNumber),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).appointmentDateForm,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(widget.appointment.date)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).appointmentTimeForm,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(widget.appointment.time)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).wasNecessary,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                        value: widget.appointment.necessary,
                        onChanged: (bool? val) {
                          setState(() {
                            widget.appointment.necessary = val!;
                          });
                        })
                  ],
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).wasPrescriptionIssued,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Checkbox(
                        value: widget.appointment.receiptGiven,
                        onChanged: (bool? val) {
                          setState(() {
                            widget.appointment.receiptGiven = val!;
                          });
                        })
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).prescribedMedicine,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                _medicineTable(itemsCount),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).visitRemarks,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildCommentSection(_visitRemarksController),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).patientRemarks,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildCommentSection(_patientRemarksController),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 40, 20),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).send,
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(const Size(100, 50)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.teal),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )))),
                ),
              ],
            ),
          ),
        )));
  }

  _medicineTable(int itemCount) {
    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Text(S.of(context).nameDrug),
      ),
      DataColumn(
        label: Row(
          children: [
            Text(S.of(context).doses),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    builder: (BuildContext context) =>
                        _buildMedicineForm(itemCount),
                    context: context);
              },
              child: Icon(Icons.edit),
            )
          ],
        ),
      ),
    ], rows: [
      for (var data in chosenMedicineList)
        DataRow(cells: [
          DataCell(Text(data.name)),
          DataCell(Text("${data.doses} ${data.unit} ${data.schedule}")),
        ]),
    ]);
  }

  _buildCommentSection(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
      child: TextField(
          maxLines: 5,
          controller: controller,
          decoration: InputDecoration(
            // isDense: true,                      // Added this
            // contentPadding: EdgeInsets.all(8),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          )),
    );
  }

  _buildMedicineForm(int itemCount) {
    return Material(
      child: Container(
          width: 300.0,
          height: MediaQuery.of(context).size.height * 0.39,
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 10, 20, 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(310, 0, 0, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.exit_to_app,
                      size: 35,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.teal, width: 2.0))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(27, 8, 20, 8),
                        child: Text(
                          S.of(context).medicineList,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).chosenMedicine,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 440,
                  child: ListView.builder(
                      itemCount: itemCount + 1,
                      itemBuilder: (context, index) {
                        if (index < itemCount) {
                          return _buildRecord(index);
                        } else {
                          return _buildAddMedicine(context);
                          // return _buildAddMedicine(context, index);
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(180, 10, 0, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(110, 60)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.teal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    child: Text(
                      S.of(context).next,
                      style: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      for (int i = 0; i < chosenMedicineList.length; i++) {
                        TextEditingController dosage = TextEditingController();
                        dosage.text = "0";
                        dosageList.add(dosage);
                        unitList.add("ml");
                        scheduleList.add("a day");
                      }
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) => _buildDosageForm());
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _buildDosageForm() {
    return Material(
      child: Container(
          width: 300.0,
          height: MediaQuery.of(context).size.height * 0.39,
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 10, 20, 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(310, 0, 0, 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.exit_to_app,
                      size: 35,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.teal, width: 2.0))),
                      child:  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).medicineList,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).dosage,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 440,
                  child: ListView(children: [
                    for (int i = 0; i < chosenMedicineList.length; i++)
                      _buildDosageRecord(i)
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(180, 10, 0, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(110, 60)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.teal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    child:  Text(
                      S.of(context).finish,
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      for (int i = 0; i < chosenMedicineList.length; i++) {
                        try {
                          chosenMedicineList[i].doses =
                              int.parse(dosageList[i].text);
                        } on Exception {
                          showDialog(
                              context: context,
                              builder: (context) =>  AlertDialog(
                                  title: Text(S.of(context).incorrectDosageInput),
                                  content: Text(
                                      S.of(context).dosageInputsMustBeAlphanumeric)));
                        }

                        chosenMedicineList[i].schedule = scheduleList[i];
                        chosenMedicineList[i].unit = unitList[i];
                      }
                      dosageList.clear();
                      unitList.clear();
                      scheduleList.clear();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _buildRecord(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        children: [
          Material(
            child: InkWell(
              onTap: () {
                if (medicineList.length > index) {
                  chosenMedicineList.add(medicineList.removeAt(index));
                  int itemCount =
                      medicineList.length > chosenMedicineList.length
                          ? medicineList.length
                          : chosenMedicineList.length;
                  print(itemCount);
                  setState(() {});
                  Navigator.of(context).pop();
                  showDialog(
                      builder: (BuildContext context) =>
                          _buildMedicineForm(itemCount),
                      context: context);
                }
              },
              child: Container(
                width: 150,
                height: 40,
                color: const Color(0x6B70DBB6),
                child: Center(
                  child: medicineList.length > index
                      ? Text(medicineList[index].name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black))
                      : Text(""),
                ),
              ),
            ),
          ),
          Material(
            child: InkWell(
              onTap: () {
                if (chosenMedicineList.length > index) {
                  medicineList.add(chosenMedicineList.removeAt(index));
                  int itemCount =
                      medicineList.length > chosenMedicineList.length
                          ? medicineList.length
                          : chosenMedicineList.length;
                  print(itemCount);
                  setState(() {});
                  Navigator.of(context).pop();
                  showDialog(
                      builder: (BuildContext context) =>
                          _buildMedicineForm(itemCount),
                      context: context);
                }
              },
              child: Container(
                width: 170,
                height: 40,
                color: const Color(0x6B70DBB6),
                child: Center(
                  child: chosenMedicineList.length > index
                      ? Text(chosenMedicineList[index].name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black))
                      : Text(""),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAddMedicine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Material(
        child: InkWell(
          key: const Key("add medicine ink"),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                      title: Row(
                        children: [
                          SizedBox(width: 40),
                          Text(S.of(context).addMedicine),
                          SizedBox(
                            width: 90,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.exit_to_app,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            S.of(context).addMedicineName,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: TextFormField(
                            controller: _medicineNameController,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(50, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                       Colors.teal),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ))),
                              child: Text(
                                S.of(context).add,
                                style: TextStyle(fontSize: 17),
                              )),
                        )
                      ],
                    ));
          },
          child: Container(
            decoration: BoxDecoration(color: null),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 15, 0, 15),
              child: Row(
                children:  [
                  Icon(Icons.add),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    S.of(context).addMedicine,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildDosageRecord(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 30,
            color: const Color(0x6B70DBB6),
            child: Center(
                child: Text(chosenMedicineList[index].name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black))),
          ),
          Container(
            width: 50,
            height: 30,
            child: Center(
                child: TextFormField(
                    controller: dosageList[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black))),
          ),
          SizedBox(width: 10),
          DropdownButton(
              value: unitList[index],
              items: const [
                DropdownMenuItem(child: Text("ml"), value: "ml"),
                DropdownMenuItem(child: Text("l"), value: "l"),
                DropdownMenuItem(child: Text("cm"), value: "cm"),
                DropdownMenuItem(child: Text("dm"), value: "dm"),
              ],
              onChanged: (value) {
                if (value is String) {
                  unitList[index] = value;
                  setState(() {});

                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) => _buildDosageForm());
                }
              }),
          const SizedBox(width: 10),
          DropdownButton(
              value: scheduleList[index],
              items:  [
                DropdownMenuItem(child: Text(S.of(context).aDay), value: "a day"),
                DropdownMenuItem(child: Text(S.of(context).aWeek), value: "a week"),
                DropdownMenuItem(child: Text(S.of(context).aMonth), value: "a month"),
                DropdownMenuItem(child: Text(S.of(context).aYear), value: "a year"),
              ],
              onChanged: (value) {
                if (value is String) {
                  scheduleList[index] = value;
                  setState(() {});
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (context) => _buildDosageForm());
                }
              }),
        ],
      ),
    );
  }
}
