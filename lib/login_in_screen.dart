import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfinderprint/home_screen.dart';
import 'package:flutterfinderprint/signed_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class LoginInScreen extends StatefulWidget {
  @override
  _LoginInScreenState createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  final controllerUsername = new TextEditingController();
  final controllerPass = new TextEditingController();
  bool isTouchID = false;
  bool showTouchIdOption = false;
  SignedInPage fingerPrintCheck;

  @override
  void initState() {
    super.initState();
    fingerPrintCheck = SignedInPage();
    fingerPrintCheck.isFingerPrintSensorPresent().then((value) {
      if (value) {
        setState(() {
          showTouchIdOption = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: <Widget>[
                _signIn(),
                _username(),
                _password(),
                _touchIdCheck(),
                _loginButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell _loginButton(BuildContext context) {
    return InkWell(
      onTap: () {
//                  SignedInPage(isTouchID: false,user: username,password: password);
        if (controllerUsername.text == 'admin' &&
            controllerPass.text == 'admin') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SuccessHomeScreen()));
        } else
          print(" Invalid credentials");
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 34.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        child: Text(
          'LOG IN',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _touchIdCheck() {
    if (showTouchIdOption) {
      return _touchId();
    }
    return SizedBox();
  }

  _touchId() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: isTouchID,
          onChanged: (value) {
            if (value) {
              fingerPrintCheck.isFingerPrintAdded().then((isFingerPrintAdded) {
                if (isFingerPrintAdded) {
                  setState(() {
                    isTouchID = value;
                  });

                  // Save username and password to shared pref.
                  // Save isTouchEnabled in shared pref.
                  _saveData(controllerUsername.text, controllerPass.text, true);
                }
              });
            } else {
              isTouchID = value;
              // Remove username and password from shared pref.
              // Remove isTouchEnabled from shared pref.
              _saveData('', '', false);
            }
            // logic of first time user
          },
        ),
        Text('Login using Touch ID')
      ],
    );
  }

  TextField _password() {
    return TextField(
      controller: controllerPass,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
        )),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        focusColor: Colors.green,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.orange,
        fontSize: 22.0,
      ),
    );
  }

  TextField _username() {
    return TextField(
      controller: controllerUsername,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
        )),
        hintText: 'Enter Email',
        hintStyle: TextStyle(color: Colors.orange),
        focusColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.blue,
        fontSize: 22.0,
      ),
    );
  }

  Text _signIn() {
    return Text(
      'SIGN IN',
      style: TextStyle(
        color: Colors.orange,
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void _saveData(String username, String password, bool isTouchEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedKeys.USERNAME, username);
    prefs.setString(SharedKeys.PASSWORD, password);
    prefs.setBool(SharedKeys.IS_TOUCH_ENABLED, isTouchEnabled);
  }
}
