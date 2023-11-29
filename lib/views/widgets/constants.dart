import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Constants {
  static Color kPrimaryColor = const Color(0xFF6F35A5);
  static Color kPrimaryLightColor = const Color(0xFFF1E6FF);
  static String teamName = "Team Name*";
  static String playerName = "Player Name*";
  static String captainName = "Captain Name*";
  static String specialization = "Specialization*";
  static String captainMobNum = "Captain Mobile No.*";
  static String playerMobNum = "Player Mobile No.*";
  static String captainAge = "Age*";
  static String captainAadhar = "Captain Aadhar*";
  static String playerAadhar = "Player Aadhar*";
  static String tshirtSize = "T Shirt Size";
  static String jerseyNumber = "Jersey Number";
  static String aadharFrontside = "Aadhar Front*";
  static String aadharBackside = "Aadhar Back*";
  static String profilePic = "Profile Picture*";
  static String address = "Address*";
  static String panchayathi = "Panchayathi*";
  static String mandal = "Mandalam*";
  static String district = "District*";
  static String landMark = "Land Mark*";
  static String registrationHintText = "Only 6 Alphabets";
  static String welcomeHeader = "Welcome!";
  static String newTeam = "NEW TEAM";
  static String setPinTitle = "set PIN to create & secure your wallet";
  static String enterPIN = "Enter PIN*";
  static String loginEnterPIN = "Enter PIN";
  static String biometricUnlock = "Unlock using Biometric/Face ID";
  static String reenterPIN = "Re - enter PIN*";
  static String seconds = "seconds";
  static String reqOTP = "Request OTP in";
  static String notYou = "Not You?";
  static String submitButton = "Submit";
  static String loginButton = "LOGIN";
  static String loginNowButton = "LOGIN NOW";
  static String nextButton = "Next";
  static String resendCode = "Resend Code";
  static String forgetPin = "Forgit PIN?";
  static String cricketFan = "I'M A CRICKET FAN";
  static String termsAndConditions = "Terms & Conditions";
  static String registrationHeader = "Registration";
  static String teamregistrationHeader = "Team Registration";
  static String matchScheduleHeader = "Match Schedule";
  static String setpinHeader = "Final Step!";
  static String topstoriesHeader = "Top Stories";
  static String loginHintText = "Enter Your Mobile Number";
  static String loginAlertMsg = "Enter Valid Mobile Number";
  static String tncAlertMsg = "Please accept Terms & Conditions";
  static String otpAlertMsg = "Enter Valid OTP";
  static String registersuccessText = "Congratulations!";
  static String registeronText = "Your team have successfully registered on";
  static String invalidOtp = "OTP entered is invalid";
  static String aadharAlertMsg = "Enter Valid Aadhar Number";
  static String aadharFrontAlertMsg = "Please upload Aadhar Front Image";
  static String aadharBackAlertMsg = "Please upload Aadhar Back Image";
  static String profileAlertMsg = "Please upload Profile picture";
  static String ageAlertMsg = "Enter Valid Age";
  static String addressAlertMsg = "Enter Valid Address(Minimum 3 characters)";
  static String panchayatAlertMsg = "Enter Panchayathi";
  static String mandalAlertMsg = "Select Mandalam";
  static String districtAlertMsg = "Select District";
  static String specializationAlertMsg = "Select specialization";
  static String shirtAlertMsg = "Select shirt size";
  static String jerseyAlertMsg = "Enter jersey number";
  static String registrationTeamNameAlertMsg =
      "Team Name Must Be Atleast 3 Characters";
  static String registrationPlayerNameAlertMsg = "Enter Player name";
  static String registrationCapNameAlertMsg =
      "Captain Name Required(atleast 3 characters)";
  static String continueButton = "Continue";
  static String addPlayerButton = "Add Player";
  static String saveButton = "Save";
  static String verificationHeader = "Verification";
  static String smsHeader = "We sent you an SMS code";
  static String specializationHintText = "Batsman";
  static String pinCheck = "PIN's entered are not matching";
  static String enterpinCheck = "Please check Enter PIN";
  static String reenterpinCheck = "Please check Re-enter PIN";
  static String onNumber = "On Number";
  static String otpHint = "Enter OTP";
  static String someThingWentWrong = "Something went wrong! Please try later";
  static String successText = "Success";
  static String teamsText = "TEAMS";
  static String otpVerified = "OTP Verified Successfully";
  static String acceptTnC = "I accept Terms & Conditions";
  static double defaultPadding = 16.0;
  static double headerSize = 16.0;
  static double welcomeTextSize = 24.0;
  static double loginBtnTextSize = 20.0;
  static double subHeaderSize = 14.0;
  static double labelSize = 10.0;
  static double textSize = 12.0;
  static double loginTextFieldHeight = 60.0;
  static double registrationTextFieldHeight = 50.0;
  static double registrationAddressTextFieldHeight = 80.0;
  static double backIconSize = 30.0;
  static double gapBetweenFields = 10;
  static double gapBetweenFields1 = 20;
  static Color textFieldFilledColor = Colors.black12;
  static Color teamNameHintTextColor = Colors.black38;
  static Color backIconColor = const Color(0xFFff0041);
  static Color buttonRed = const Color(0xFFff0041);
  static Color green = const Color(0xFF216f82);
  static Color darkgrey = const Color(0xFF39454b);
  static Color lightgrey = const Color(0xFFc6c6c6);
  static Color bgColor = const Color(0xFFe7e7e7);
  static Color cardColor = const Color(0xFFdbdbdb);
  static Color editcolor = const Color(0xFFdbdbdb);
  static Color singinBgColor = const Color(0xFFFFFFFF);
  static Color navyBlue = const Color(0xFF000b40);
  static Color disablecolor = Colors.black26;
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color blueColor = Colors.blue;
  static Color transparentColor = Colors.transparent;
  static Color buttonTextColor = Colors.white;
  static Color greenAccent = Colors.greenAccent;
  static Color blueGrey = Colors.blueGrey;
  static String logoImage = "assets/images/spl_logo.png";
  static String ballImage = "assets/images/ball.png";
  static String bgImage = "assets/images/bgimage.png";
  static String defaultUserImage = "assets/images/user.jpg";
  static String successImage = "assets/images/congratulations.jpg";
  static String cricImage = "assets/images/cricketimage.png";
  static String storyImage = "assets/images/storyImage.jpg";
  static Icon cameraIcon = const Icon(Icons.camera_alt);


  static void easyLoader() {
    EasyLoading.instance
    // ..displayDuration = const Duration(seconds: 5)
      ..textStyle = TextStyle(fontWeight: FontWeight.bold, color: buttonRed)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..backgroundColor = whiteColor
      ..userInteractions = false
      ..indicatorColor = buttonRed
      ..indicatorWidget = SizedBox(
        width: 80,
        height: 80,
        child: SpinKitCubeGrid(
          color: buttonRed,
          size: 60.0,
        ),
      )
      ..infoWidget = SizedBox(
        width: 80,
        height: 80,
        child: Center(
            child: Icon(
              Icons.error,
              color: buttonRed,
              size: 50,
            )),
      )
      ..successWidget = SizedBox(
        width: 80,
        height: 80,
        child: Center(
            child: Icon(
              Icons.check,
              color: buttonRed,
              size: 50,
            )),
      )
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false;
  }

}
