import 'dart:ffi';

class AppointmentList {
  Map appointmentMap = {
    "Monday": [
      {
        "id": 16,
        "date": "2022-05-16",
        "time": "09:37:58",
        "length": 60,
        "patientName": "Testo",
        "patientSurname": "Testo-Testingowy",
        "telephoneNumber": "123456789",
        "roomNumber": "Testow i Badan",
        "roomSpecialization" : "Jak sama nazwa wskazuje"
        }
    ],
    "Tuesday": [

    ],
    "Wednesday": [

    ],
    "Thursday": [

    ],
    "Friday": [
  
    ]
  };
  List getDays(){
    return appointmentMap.keys.toList();
  }
  List getMonday(){
    return appointmentMap["Monday"];
  }
  List getTuesday(){
    return appointmentMap["Tuesday"];
  }
  List getWednesday(){
    return appointmentMap["Wednesday"];
  }
  List getThursday(){
    return appointmentMap["Thursday"];
  }
  List getFriday(){
    return appointmentMap["Friday"];
  }
  setAppointmentMap(map){
    assert(map != null);
    appointmentMap = map;
  }
  int length(){
    return appointmentMap.length;
  }

  List getDay(int weekday) {
    switch(weekday){
      case 0:
        return getMonday();
      case 1:
        return getTuesday();
      case 2:
        return getWednesday();
      case 3:
        return getThursday();
      case 4:
        return getFriday();
      default:
        return getMonday();
    }

  }
}
