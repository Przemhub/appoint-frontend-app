class Medicine {
  late int id;
  late int doses;
  late String name;
  late String remarks;
  late String schedule;
  late String prescriptionDate;
  late String unit;
  Medicine();

  Medicine.full({required this.id, required this.doses, required this.name, required this.remarks, required this.prescriptionDate, required this.schedule, required this.unit});

  Medicine.withoutId({required this.doses, required this.name, required this.remarks,required this.prescriptionDate, required this.schedule, required this.unit});
}
