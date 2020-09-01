import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SignedInPage {
//  final String user;
//  final String password;
//  final bool isTouchID;

//  SignedInPage({@required this.isTouchID});

  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isFingerPrintSensorPresent() async {
    var canCheck = await auth.canCheckBiometrics;
   return canCheck;

  }

  Future<bool> isFingerPrintAdded() async {
    bool _popuphandler = false;
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
//    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      _popuphandler = await auth.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
//    } else{
//
//    }
    return _popuphandler;
  }

/*  Future<bool> authenticate() async {
    var canCheck = await auth.canCheckBiometrics;

    if (canCheck) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        try {
          canCheck = await auth.authenticateWithBiometrics(
            localizedReason: "Please authenticate to complete your transaction",
            useErrorDialogs: true,
            stickyAuth: true,
          );
        } on PlatformException catch (e) {
          print(e);
        }
        return isTouchID;
      }
    } else {
      print('cant check');
      return !isTouchID;
    }
  }*/
}
