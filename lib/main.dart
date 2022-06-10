import 'package:appoint_webapp/doctor/appointment_form.dart';
import 'package:appoint_webapp/login_page.dart';
import 'package:appoint_webapp/secretary/schedule_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'doctor/list_of_appointments.dart';
import 'generated/l10n.dart';
import 'model/AppointmentInfo.dart';

String? selectedNotificationPayload;
final BehaviorSubject<String?> selectNotificationSubject =
BehaviorSubject<String?>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
String _timezone = 'Unknown';
List<String> _availableTimezones = <String>[];
bool notificationStarted = false;
void main() async{


  runApp(const MyApp());
}
Future<void> _configureLocalTimeZone() async {
  DateTime dateTime = DateTime.now();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Europe/Warsaw"));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  _initNotifications(BuildContext context) async{
    WidgetsFlutterBinding.ensureInitialized();
    _configureLocalTimeZone();
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();


    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            print(payload);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => AppointmentForm(user: user, appointment: null,)));
          }
          selectedNotificationPayload = payload;
          selectNotificationSubject.add(payload);
        });
  }
  @override
  Widget build(BuildContext context) {
    _initNotifications(context);
    return MaterialApp(
        title: 'Appoint',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        localizationsDelegates: const [
          // ... app-specific localization delegate[s] here
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: const [
          Locale('en', ''),
          Locale('pl','')// English
          // ... other locales the app supports
        ],
        home: LoginPage());
  }
}
