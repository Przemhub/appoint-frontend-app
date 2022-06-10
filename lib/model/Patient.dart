class Patient {
  late int id;
  late String name;
  late String surname;
  late String telephoneNumber;
  late DateTime dateOfRegister;
  // late String pesel;

  Patient(this.name, this.surname, this.telephoneNumber) {
    dateOfRegister = DateTime.now();
  }
  Patient.Id(id, name, surname, telephoneNumber) {
    this.id=id;
    this.name=name;
    this.surname=surname;
    this.telephoneNumber=telephoneNumber;
  }
}
