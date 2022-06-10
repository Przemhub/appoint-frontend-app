import 'dart:collection';
import 'dart:convert';

import 'package:appoint_webapp/doctor/list_of_appointments.dart';
import 'package:appoint_webapp/secretary/schedule_appointment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'generated/l10n.dart';
import 'model/User.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          S.of(context).loginPage,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignInForm(),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

User user = User();

class _SignInFormState extends State<SignInForm> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  double _formProgress = 0;

  static const SERVER_IP = 'https://pz-backend2022.herokuapp.com';

  void _updateFormProgress() {
    var progress = 0.0;
    var controllers = [_passwordTextController, _emailTextController];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  signIn() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userEmail = _emailTextController.text;
    var password = _passwordTextController.text;

    final tokens = json.decode(await attemptLogIn(userEmail, password));
    print(tokens.runtimeType.toString());
    print("User logged in succesfully");
    if (tokens != null) {
      print("user token: $tokens");
      user.token = tokens['token'];
      user.refreshToken = tokens['refreshToken'];
      user.username = userEmail;
      Map decodedToken = parseJwt(user.token);
      if (decodedToken['role'] == "administrator") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScheduleAppointment(
                      user: user,
                    )));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListOfAppointments(
                      user: user,
                    )));
      }
    } else {
      displayDialog(
          context, S.of(context).bd, S.of(context).emailLubHasoNieJestPoprawne);
    }
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  Future<String> attemptLogIn(String email, String password) async {
    print('serverip:$SERVER_IP');
    print('password:$password');
    print('email:$email');
    print(jsonEncode(<String, String>{"login": email, "password": password}));
    var res = await http.post(Uri.parse("$SERVER_IP/api/Auth/Login"),
        body:
            jsonEncode(<String, String>{"login": email, "password": password}),
        headers: <String, String>{"Content-Type": "application/json"});

    print(res.statusCode);
    print(res.body);
    if (res.body.isNotEmpty) {
      return res.body;
    } else
      return "";
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Image.asset(
            'assets/logo1.png',
            color: Colors.teal,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          S.of(context).logIn,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 60,
        ),
        _buildTextField(S.of(context).username),
        const SizedBox(
          height: 30,
        ),
        _buildPasswordField(),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
            onPressed: () {
              signIn();
            },
            child: Text(
              S.of(context).login,
              style: const TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ))))
      ],
    );
  }

  _buildTextField(String hintText) {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            controller: hintText == S.of(context).username
                ? _emailTextController
                : _passwordTextController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: hintText,
            )),
      ),
    );
  }

  _buildPasswordField() {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _passwordTextController,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: S.of(context).password)),
      ),
    );
  }
}
