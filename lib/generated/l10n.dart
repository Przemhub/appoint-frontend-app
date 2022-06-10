// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `App. List`
  String get appList {
    return Intl.message(
      'App. List',
      name: 'appList',
      desc: '',
      args: [],
    );
  }

  /// `App. History`
  String get appHistory {
    return Intl.message(
      'App. History',
      name: 'appHistory',
      desc: '',
      args: [],
    );
  }

  /// `Appointment History`
  String get appointmentHistory {
    return Intl.message(
      'Appointment History',
      name: 'appointmentHistory',
      desc: '',
      args: [],
    );
  }

  /// `Patient Name:`
  String get patientName {
    return Intl.message(
      'Patient Name:',
      name: 'patientName',
      desc: '',
      args: [],
    );
  }

  /// `App. Date:`
  String get appDate {
    return Intl.message(
      'App. Date:',
      name: 'appDate',
      desc: '',
      args: [],
    );
  }

  /// `App. Status:`
  String get appStatus {
    return Intl.message(
      'App. Status:',
      name: 'appStatus',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Appointment`
  String get scheduleAppointment {
    return Intl.message(
      'Schedule Appointment',
      name: 'scheduleAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Choose date`
  String get chooseDate {
    return Intl.message(
      'Choose date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm date`
  String get confirmDate {
    return Intl.message(
      'Confirm date',
      name: 'confirmDate',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get date {
    return Intl.message(
      'Date:',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor {
    return Intl.message(
      'Doctor',
      name: 'doctor',
      desc: '',
      args: [],
    );
  }

  /// `Room: `
  String get room {
    return Intl.message(
      'Room: ',
      name: 'room',
      desc: '',
      args: [],
    );
  }

  /// `Speciality`
  String get speciality {
    return Intl.message(
      'Speciality',
      name: 'speciality',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Patient List`
  String get patientList {
    return Intl.message(
      'Patient List',
      name: 'patientList',
      desc: '',
      args: [],
    );
  }

  /// `Name/Surname`
  String get namesurname {
    return Intl.message(
      'Name/Surname',
      name: 'namesurname',
      desc: '',
      args: [],
    );
  }

  /// `Please choose speciality`
  String get pleaseChooseSpeciality {
    return Intl.message(
      'Please choose speciality',
      name: 'pleaseChooseSpeciality',
      desc: '',
      args: [],
    );
  }

  /// `Add Patient`
  String get addPatient {
    return Intl.message(
      'Add Patient',
      name: 'addPatient',
      desc: '',
      args: [],
    );
  }

  /// `Register Patient`
  String get registerPatient {
    return Intl.message(
      'Register Patient',
      name: 'registerPatient',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Field `
  String get field {
    return Intl.message(
      'Field ',
      name: 'field',
      desc: '',
      args: [],
    );
  }

  /// ` is missing, please fill it`
  String get isMissingPleaseFillIt {
    return Intl.message(
      ' is missing, please fill it',
      name: 'isMissingPleaseFillIt',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get appointSchedule {
    return Intl.message(
      'Schedule',
      name: 'appointSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Appointment Form`
  String get appointmentForm {
    return Intl.message(
      'Appointment Form',
      name: 'appointmentForm',
      desc: '',
      args: [],
    );
  }

  /// `Name:`
  String get nameForm {
    return Intl.message(
      'Name:',
      name: 'nameForm',
      desc: '',
      args: [],
    );
  }

  /// `Surname:`
  String get surnameForm {
    return Intl.message(
      'Surname:',
      name: 'surnameForm',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number:`
  String get phoneNumberForm {
    return Intl.message(
      'Phone Number:',
      name: 'phoneNumberForm',
      desc: '',
      args: [],
    );
  }

  /// `Appointment date:`
  String get appointmentDateForm {
    return Intl.message(
      'Appointment date:',
      name: 'appointmentDateForm',
      desc: '',
      args: [],
    );
  }

  /// `Appointment time:`
  String get appointmentTimeForm {
    return Intl.message(
      'Appointment time:',
      name: 'appointmentTimeForm',
      desc: '',
      args: [],
    );
  }

  /// `Was necessary?`
  String get wasNecessary {
    return Intl.message(
      'Was necessary?',
      name: 'wasNecessary',
      desc: '',
      args: [],
    );
  }

  /// `Was prescription issued?`
  String get wasPrescriptionIssued {
    return Intl.message(
      'Was prescription issued?',
      name: 'wasPrescriptionIssued',
      desc: '',
      args: [],
    );
  }

  /// `Prescribed medicine`
  String get prescribedMedicine {
    return Intl.message(
      'Prescribed medicine',
      name: 'prescribedMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Visit remarks`
  String get visitRemarks {
    return Intl.message(
      'Visit remarks',
      name: 'visitRemarks',
      desc: '',
      args: [],
    );
  }

  /// `Patient remarks`
  String get patientRemarks {
    return Intl.message(
      'Patient remarks',
      name: 'patientRemarks',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameDrug {
    return Intl.message(
      'Name',
      name: 'nameDrug',
      desc: '',
      args: [],
    );
  }

  /// `Doses`
  String get doses {
    return Intl.message(
      'Doses',
      name: 'doses',
      desc: '',
      args: [],
    );
  }

  /// `Medicine List`
  String get medicineList {
    return Intl.message(
      'Medicine List',
      name: 'medicineList',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Patient Statistics`
  String get patientStatistics {
    return Intl.message(
      'Patient Statistics',
      name: 'patientStatistics',
      desc: '',
      args: [],
    );
  }

  /// `General Information`
  String get generalInformation {
    return Intl.message(
      'General Information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `PESEL:`
  String get pesel {
    return Intl.message(
      'PESEL:',
      name: 'pesel',
      desc: '',
      args: [],
    );
  }

  /// `Visit date:`
  String get visitDate {
    return Intl.message(
      'Visit date:',
      name: 'visitDate',
      desc: '',
      args: [],
    );
  }

  /// `Visit time:`
  String get visitTime {
    return Intl.message(
      'Visit time:',
      name: 'visitTime',
      desc: '',
      args: [],
    );
  }

  /// `Is urgent?:`
  String get isUrgent {
    return Intl.message(
      'Is urgent?:',
      name: 'isUrgent',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `App. Form`
  String get appForm {
    return Intl.message(
      'App. Form',
      name: 'appForm',
      desc: '',
      args: [],
    );
  }

  /// `Appointment started`
  String get appointmentStarted {
    return Intl.message(
      'Appointment started',
      name: 'appointmentStarted',
      desc: '',
      args: [],
    );
  }

  /// `Your appointment on`
  String get yourAppointmentOn {
    return Intl.message(
      'Your appointment on',
      name: 'yourAppointmentOn',
      desc: '',
      args: [],
    );
  }

  /// `at`
  String get at {
    return Intl.message(
      'at',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `has started!`
  String get hasStarted {
    return Intl.message(
      'has started!',
      name: 'hasStarted',
      desc: '',
      args: [],
    );
  }

  /// `List Of Appointments`
  String get listOfAppointments {
    return Intl.message(
      'List Of Appointments',
      name: 'listOfAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Login Page`
  String get loginPage {
    return Intl.message(
      'Login Page',
      name: 'loginPage',
      desc: '',
      args: [],
    );
  }

  /// `Email or password are incorrect`
  String get emailLubHasoNieJestPoprawne {
    return Intl.message(
      'Email or password are incorrect',
      name: 'emailLubHasoNieJestPoprawne',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get bd {
    return Intl.message(
      'Error',
      name: 'bd',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get username {
    return Intl.message(
      'username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Nbr: `
  String get tel {
    return Intl.message(
      'Nbr: ',
      name: 'tel',
      desc: '',
      args: [],
    );
  }

  /// `Please choose appointment and patient`
  String get pleaseChooseAppointmentAndPatient {
    return Intl.message(
      'Please choose appointment and patient',
      name: 'pleaseChooseAppointmentAndPatient',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor2 {
    return Intl.message(
      'Doctor',
      name: 'doctor2',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient2 {
    return Intl.message(
      'Patient',
      name: 'patient2',
      desc: '',
      args: [],
    );
  }

  /// `No appointment slots on this day`
  String get noAppointmentSlotsOnThisDay {
    return Intl.message(
      'No appointment slots on this day',
      name: 'noAppointmentSlotsOnThisDay',
      desc: '',
      args: [],
    );
  }

  /// `Error getting appointments`
  String get errorGettingAppointments {
    return Intl.message(
      'Error getting appointments',
      name: 'errorGettingAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Oncoming appointments`
  String get oncomingAppointments {
    return Intl.message(
      'Oncoming appointments',
      name: 'oncomingAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Speciality: `
  String get roomSpecialisation {
    return Intl.message(
      'Speciality: ',
      name: 'roomSpecialisation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel appointment on`
  String get areYouSureYouWantToCancelAppointmentOn {
    return Intl.message(
      'Are you sure you want to cancel appointment on',
      name: 'areYouSureYouWantToCancelAppointmentOn',
      desc: '',
      args: [],
    );
  }

  /// `Cancel appointment`
  String get cancelAppointment {
    return Intl.message(
      'Cancel appointment',
      name: 'cancelAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Visit removed successfully`
  String get visitRemovedSuccessfully {
    return Intl.message(
      'Visit removed successfully',
      name: 'visitRemovedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error removing visit`
  String get errorRemovingVisit {
    return Intl.message(
      'Error removing visit',
      name: 'errorRemovingVisit',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `Visit saved successfully`
  String get visitSavedSuccessfully {
    return Intl.message(
      'Visit saved successfully',
      name: 'visitSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error saving visit`
  String get errorSavingVisit {
    return Intl.message(
      'Error saving visit',
      name: 'errorSavingVisit',
      desc: '',
      args: [],
    );
  }

  /// `Add Medicine`
  String get addMedicine {
    return Intl.message(
      'Add Medicine',
      name: 'addMedicine',
      desc: '',
      args: [],
    );
  }

  /// `a day`
  String get aDay {
    return Intl.message(
      'a day',
      name: 'aDay',
      desc: '',
      args: [],
    );
  }

  /// `a week`
  String get aWeek {
    return Intl.message(
      'a week',
      name: 'aWeek',
      desc: '',
      args: [],
    );
  }

  /// `a month`
  String get aMonth {
    return Intl.message(
      'a month',
      name: 'aMonth',
      desc: '',
      args: [],
    );
  }

  /// `a year`
  String get aYear {
    return Intl.message(
      'a year',
      name: 'aYear',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Add medicine name`
  String get addMedicineName {
    return Intl.message(
      'Add medicine name',
      name: 'addMedicineName',
      desc: '',
      args: [],
    );
  }

  /// `Dosage inputs must be alphanumeric`
  String get dosageInputsMustBeAlphanumeric {
    return Intl.message(
      'Dosage inputs must be alphanumeric',
      name: 'dosageInputsMustBeAlphanumeric',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect dosage input!`
  String get incorrectDosageInput {
    return Intl.message(
      'Incorrect dosage input!',
      name: 'incorrectDosageInput',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Dosage`
  String get dosage {
    return Intl.message(
      'Dosage',
      name: 'dosage',
      desc: '',
      args: [],
    );
  }

  /// `Chosen Medicine`
  String get chosenMedicine {
    return Intl.message(
      'Chosen Medicine',
      name: 'chosenMedicine',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
