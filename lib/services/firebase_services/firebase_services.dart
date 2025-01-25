import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;

  Future<bool?> sendOtp(String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          Fluttertoast.showToast(msg: 'OTP Send');
        },
        verificationFailed: (FirebaseException e) {

        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
    } on FirebaseException {
      throw Exception('');
    } catch (e) {
      throw Exception(e);
    }
  }

    Future<bool> verifyOtp(String verificationId, String otp) async {
      bool isVerified = false;
      try {
        PhoneAuthCredential credential = await PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp);
        auth.signInWithCredential(credential).then((value) {
          isVerified = true;
        });
        return isVerified;
      } catch (e) {
        print(e);
        return isVerified;
      }
    }
  }


