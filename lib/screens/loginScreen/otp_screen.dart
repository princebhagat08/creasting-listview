import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';
import 'package:youbloomdemo/config/color/color.dart';
import 'package:youbloomdemo/config/images/images.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size size = MediaQuery.of(context).size;

    final List<TextEditingController> _otpControllers =
        List.generate(6, (index) => TextEditingController());

    String getOtp() {
      return _otpControllers.map((controller) => controller.text).join();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          // Adjust horizontal padding based on screen width
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06, // 6% of screen width
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image and heading section
              Image.asset(
                otpLogo,
                height: size.height * 0.15, // 15% of screen height
              ),
              SizedBox(height: size.height * 0.05), // 5% of screen height
              Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                'We have sent a verification code to your mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: fontFamily,
                  fontSize: size.width * 0.035, // 3.5% of screen width
                ),
              ),
              SizedBox(height: size.height * 0.05),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: size.width * 0.12, // 12% of screen width
                    height: size.width * 0.12, // Square aspect ratio
                    child: TextField(
                      controller: _otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: size.width * 0.05, // 5% of screen width
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),
              // Verify button
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06, // 6% of screen height
                  child: ElevatedButton(
                    onPressed: () {
                      if (getOtp().length == 6) {
                        context
                            .read<LoginBloc>()
                            .add(ValidateOTP(verificationId, getOtp()));
                        state.isVerified
                            ? Navigator.pushReplacementNamed(
                                context, RoutesName.home)
                            : null;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getOtp().length == 6
                          ? AppColor.primaryColor
                          : AppColor.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                      ),
                    ),
                    child: Text(
                      'Verify',
                      style: mediumWhiteText,
                    ),
                  ),
                );
              }),

              SizedBox(height: size.height * 0.025),
              // Resend code text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
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
                      'Resend',
                      style: smallBoldColorText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
