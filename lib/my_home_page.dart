import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfinderprint/login_in_screen.dart';
import 'package:local_auth/local_auth.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


//
//  @override
//  void initState() {
//    super.initState();
//    getSecureStorage();
//  }
//
//  void getSecureStorage() async {
//    final isUsingBio = await storage.read(key: 'usingBiometric');
//    setState(() {
//      userHasTouchId = isUsingBio == 'true';
//    });
//  }



  bool isTouchID = false;
//  final LocalAuthentication _localAuthentication = LocalAuthentication();
//  bool _canCheckBiometric = false;
//  String _authorizedOrNot = "Not Authorized";
//  List<BiometricType> _availableBiometricTypes = List<BiometricType>();
/*

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginInScreen(),

//            Text("Authorized : $_authorizedOrNot"),

          ],
        ),
      ),
    );
  }
}
