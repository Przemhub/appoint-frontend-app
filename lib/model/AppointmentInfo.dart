class ArchivedAppointment {
  late String patientName;
  late String patientSurname;
  late String date;
  late String status;

  late String time;
  late String phoneNumber;
  late bool tookPlace;
  late int duration;
  late bool necessary = false;
  late String patientRemarks;
  late String visitRemarks;
  late bool receiptGiven = false;

  ArchivedAppointment(
      this.patientName, this.patientSurname, this.date, this.status);

  ArchivedAppointment.withDetailedInfo(
      this.patientName,
      this.patientSurname,
      this.date,
      this.status,
      this.duration,
      this.necessary,
      this.patientRemarks,
      this.receiptGiven,
      this.tookPlace,
      this.visitRemarks,
      this.time,
      this.phoneNumber);

  ArchivedAppointment.fromNewAppointment(NewAppointment newAppointment) {
    patientName = newAppointment.patientName;
    patientSurname = newAppointment.patientSurname;
    date = newAppointment.date;
    phoneNumber = newAppointment.phoneNumber;
    time = newAppointment.time;
  }
}

class NewAppointment {
  late int id;
  late String patientName;
  late String patientSurname;
  late String phoneNumber;
  late String date;
  late String time;
  late String roomNumber;
  late String roomSpecialization;
  late int length;

  NewAppointment(
      {required this.id,
      required this.patientName,
      required this.patientSurname,
      required this.phoneNumber,
      required this.date,
      required this.time,
      required this.length,
      required this.roomNumber,
      required this.roomSpecialization});
}
