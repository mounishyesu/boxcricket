import 'package:boxcricket/views/home/homepage.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({super.key});

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const CongratulationsScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const CongratulationsScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({super.key});

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
              child: Image.asset(
            Constants.successImage,
            fit: BoxFit.contain,
          )),
          SizedBox(
            height: Constants.defaultPadding,
          ),
          Text(
            Constants.registersuccessText,
            style: TextStyle(
                fontSize: Constants.loginBtnTextSize,
                fontWeight: FontWeight.bold,
                color: Constants.buttonRed),
          ),
          SizedBox(
            height: Constants.defaultPadding,
          ),
          Text(
            Constants.registeronText,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Constants.blackColor),
          ),
          SizedBox(
            height: Constants.defaultPadding*2,
          ),
          Center(
              child: Image.asset(
                Constants.logoImage,
                height: 250,
                width: 250,
              )),
          SizedBox(
            height: Constants.defaultPadding,
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(const Home());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 0.8,
              height: Constants.registrationTextFieldHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Constants.buttonRed,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30))),
              child: Text(
                Constants.loginNowButton,
                style: TextStyle(
                    color: Constants.buttonTextColor,
                    fontSize: Constants.loginBtnTextSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
