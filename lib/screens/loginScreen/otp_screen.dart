import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';
import 'package:youbloomdemo/config/color/color.dart';
import 'package:youbloomdemo/config/images/images.dart';
import 'package:youbloomdemo/config/internationalization/language.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';
import 'package:youbloomdemo/utils/custom_widgets/custom_alert_dialog.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final language = Language();
    // Get screen size
    final Size size = MediaQuery.of(context).size;
    String otp = '';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            // Adjust horizontal padding based on screen width
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06, // 6% of screen width
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.1,),
                // Image and heading section
                Image.asset(
                  otpLogo,
                  height: size.height * 0.15, // 15% of screen height
                ),
                SizedBox(height: size.height * 0.05), // 5% of screen height
                Text(
                  language.getText('enter_verification_code'),
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                Text(
                  language.getText('verification_code_sent'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: fontFamily,
                    fontSize: size.width * 0.035, // 3.5% of screen width
                  ),
                ),
                SizedBox(height: size.height * 0.05),

                // OTP input fields
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  cursorColor: AppColor.primaryColor,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: AppColor.whiteColor,
                    inactiveFillColor: AppColor.whiteColor,
                    selectedFillColor: AppColor.whiteColor,
                    activeColor: AppColor.primaryColor,
                    inactiveColor: Colors.grey,
                    selectedColor: AppColor.primaryColor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (value) {
                      otp = value.toString();
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),

                SizedBox(height: size.height * 0.05),
                // Verify button
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.isVerified) {
                    Navigator.pushReplacementNamed(context, RoutesName.home);
                  } else if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
                    Fluttertoast.showToast(msg: state.errorMessage ?? language.getText('something_went_wrong'),);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otp != null && otp.isNotEmpty) {
                        if (otp.length == 6) {
                          context.read<LoginBloc>().add(ValidateMockOtp(otp));
                        } else {
                          Fluttertoast.showToast(msg: language.getText('Otp_length_error'));
                        }
                      } else {
                        Fluttertoast.showToast(msg: language.getText('enter_otp'),);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                      ),
                    ),
                    child: Text(
                      language.getText('verify'),
                      style: mediumWhiteText,
                    ),
                  ),
                ),
              ),


                SizedBox(height: size.height * 0.025),
                // Resend code text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      language.getText('didnt_receive_code'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: fontFamily,
                        fontSize: size.width * 0.035, // 3.5% of screen width
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add resend logic here
                      },
                      child: Text(
                        language.getText('resend'),
                        style: smallBoldColorText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
