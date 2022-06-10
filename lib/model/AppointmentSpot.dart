
class AppointmentSpot{
  late int id;
  late String date;
  late String time;
  late String doctorName;
  late int doctorId;
  late String roomName;
  late int roomId;
  late String roomSpecialisation;

  AppointmentSpot({ required this.date, required this.time, required this.doctorName, required this.doctorId, required this.roomId, required this.roomName});
  AppointmentSpot.filled(int id, String date, String time, String roomNumber, String roomSpecialisation){
    this.id= id;
    this.date=date;
    this.time = time;
    this.roomName=roomNumber;
    this.roomSpecialisation=roomSpecialisation;
  }
}