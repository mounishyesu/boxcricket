import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/pinsetup/setpin.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const RegistrationFromScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const RegistrationFromScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationFromScreen extends StatefulWidget {
  const RegistrationFromScreen({super.key});

  @override
  State<RegistrationFromScreen> createState() => _RegistrationFromScreenState();
}

class _RegistrationFromScreenState extends State<RegistrationFromScreen> {
  String mandalDropdownValue = "";
  String districtDropdownValue = "";
  var mandalList = [];
  var districtList = [];

  TextEditingController teamNameController = TextEditingController();
  TextEditingController captainNameController = TextEditingController();
  TextEditingController captainMobNumController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController aadharNumController = TextEditingController();
  TextEditingController panchayathiController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List names = [],
      paths = [],
      baseImg = [],
      frontNames = [],
      frontPaths = [],
      backPaths = [],
      frontbaseimg = [],
      backbaseImg = [],
      backNames = [];
  File? image, selectedImage, frontSelectedImage, backSelectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMandals();
    getDistricts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.registrationHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_circle_left_sharp,
        //     size: Constants.backIconSize,
        //     color: Constants.backIconColor,
        //   ),
        //   onPressed: () => Get.back(),
        // ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.teamName,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationTextFieldHeight,
                  child: TextField(
                    controller: teamNameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Constants.textFieldFilledColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.textFieldFilledColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.textFieldFilledColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Constants.textFieldFilledColor)),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 10),
                        hintText: Constants.registrationHintText,
                        hintStyle:
                            TextStyle(color: Constants.teamNameHintTextColor)),
                    onChanged: (value) => {
                      if (value.length > 6)
                        {
                          Get.defaultDialog(
                              title: "Alert",
                              middleText:
                                  "Team Name Cannot Be More Than 6 Characters"),
                          teamNameController.clear(),
                        }
                    },
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.captainName,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationTextFieldHeight,
                  child: TextField(
                    controller: captainNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.captainMobNum,
                          style: TextStyle(fontSize: Constants.headerSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          height: Constants.registrationTextFieldHeight,
                          child: TextField(
                            enabled: false,
                            controller: captainMobNumController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Constants.textFieldFilledColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              contentPadding:
                                  const EdgeInsets.only(top: 10, left: 10),
                              hintText: Constants.mobNum,
                            ),
                            onChanged: (value) => {
                              if (value.length > 10)
                                {
                                  Get.defaultDialog(
                                    title: "Alert",
                                    middleText: "Enter Valid Mobile Number",
                                  ),
                                  captainMobNumController.clear(),
                                }
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.captainAge,
                          style: TextStyle(fontSize: Constants.headerSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          height: Constants.registrationTextFieldHeight,
                          child: TextField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Constants.textFieldFilledColor,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textFieldFilledColor)),
                              contentPadding:
                                  const EdgeInsets.only(top: 10, left: 10),
                            ),
                            onChanged: (value) => {
                              if (value.length > 2)
                                {
                                  Get.defaultDialog(
                                    title: "Alert",
                                    middleText: "Enter Valid Age",
                                  ),
                                  ageController.clear(),
                                }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.captainAadhar,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationTextFieldHeight,
                  child: TextField(
                    controller: aadharNumController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    ),
                    onChanged: (value) => {
                      if (value.length > 12)
                        {
                          Get.defaultDialog(
                              title: "Alert",
                              middleText: "Enter Valid Aadhar Number"),
                          aadharNumController.clear(),
                        }
                    },
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          Constants.aadharFrontside,
                          style: TextStyle(fontSize: Constants.subHeaderSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        GestureDetector(
                          onTap: () => frontimageDialog(),
                          child: frontNames.isEmpty
                              ? DottedBorder(
                                  child: IconButton(
                                    onPressed: () => frontimageDialog(),
                                    icon: Constants.cameraIcon,
                                    iconSize: 30,
                                  ),
                                )
                              : Image.file(
                                  File(frontPaths[0]),
                                  height: 150,
                                ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          Constants.aadharBackside,
                          style: TextStyle(fontSize: Constants.subHeaderSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        GestureDetector(
                          onTap: () => backimageDialog(),
                          child: backNames.isEmpty
                              ? DottedBorder(
                                  child: IconButton(
                                    onPressed: () => backimageDialog(),
                                    icon: Constants.cameraIcon,
                                    iconSize: 30,
                                  ),
                                )
                              : Image.file(
                                  File(backPaths[0]),
                                  height: 150,
                                ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          Constants.profilePic,
                          style: TextStyle(fontSize: Constants.subHeaderSize),
                        ),
                        SizedBox(
                          height: Constants.gapBetweenFields,
                        ),
                        GestureDetector(
                          onTap: () => imageDialog(),
                          child: names.isEmpty
                              ? DottedBorder(
                                  child: IconButton(
                                    onPressed: () => imageDialog(),
                                    icon: Constants.cameraIcon,
                                    iconSize: 30,
                                  ),
                                )
                              : Image.file(
                                  File(paths[0]),
                                  height: 150,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.address,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationAddressTextFieldHeight,
                  child: TextField(
                    controller: addressController,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    ),
                  ),
                ),
                Text(
                  Constants.panchayathi,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  height: Constants.registrationTextFieldHeight,
                  child: TextField(
                    controller: panchayathiController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.mandal,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  // height: ,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        mandalDropdownValue = newValue.toString();
                        log(mandalDropdownValue);
                      });
                    },
                    items: mandalList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['mandalam_id'],
                        child: Text(
                          item['mandalam_name'].toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                Text(
                  Constants.district,
                  style: TextStyle(fontSize: Constants.headerSize),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  // height: ,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.textFieldFilledColor)),
                      filled: true,
                      fillColor: Constants.textFieldFilledColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        districtDropdownValue = newValue.toString();
                        log(districtDropdownValue);
                      });
                    },
                    items: districtList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['district_id'],
                        child: Text(
                          item['district_name'].toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => {
          if (teamNameController.text.isEmpty ||
              teamNameController.text.length < 3)
            {
              Get.snackbar("Alert", Constants.registrationTeamNameAlertMsg,
                  backgroundColor: Constants.whiteColor,
                  overlayBlur: 5,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.registrationTeamNameAlertMsg)),
            }
          else if (captainNameController.text.isEmpty ||
              captainNameController.text.length < 3)
            {
              Get.snackbar("Alert", Constants.loginAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.registrationCapNameAlertMsg)),
            }
          else if (ageController.text.isEmpty || ageController.text.length < 2)
            {
              Get.snackbar("Alert", Constants.ageAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.ageAlertMsg)),
            }
          else if (aadharNumController.text.isEmpty ||
              aadharNumController.text.length < 12)
            {
              Get.snackbar("Alert", Constants.aadharAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.aadharAlertMsg)),
            }
          else if (frontNames.isEmpty)
            {
              Get.snackbar("Alert", Constants.aadharFrontAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.aadharFrontAlertMsg)),
            }
          else if (backNames.isEmpty)
            {
              Get.snackbar("Alert", Constants.aadharBackAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.aadharBackAlertMsg)),
            }
          else if (names.isEmpty)
            {
              Get.snackbar("Alert", Constants.profileAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.profileAlertMsg)),
            }
          else if (addressController.text.isEmpty ||
              addressController.text.length < 8)
            {
              Get.snackbar("Alert", Constants.addressAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.addressAlertMsg)),
            }
          else if (panchayathiController.text.isEmpty)
            {
              Get.snackbar("Alert", Constants.panchayatAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.panchayatAlertMsg)),
            }
          else if (mandalDropdownValue.isEmpty)
            {
              Get.snackbar("Alert", Constants.mandalAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.mandalAlertMsg)),
            }
          else if (districtDropdownValue.isEmpty)
            {
              Get.snackbar("Alert", Constants.districtAlertMsg,
                  overlayBlur: 5,
                  backgroundColor: Constants.whiteColor,
                  titleText: Text(
                    'Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.headerSize),
                  ),
                  messageText: Text(Constants.districtAlertMsg)),
            }
          else
            {
              makeRegistrationApiCall(),
              log("---------------Details Entere---------------"),
            }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          height: Constants.registrationTextFieldHeight,
          decoration: BoxDecoration(
              color: Constants.buttonRed,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(
            Constants.continueButton,
            style: TextStyle(
                color: Constants.buttonTextColor,
                fontSize: Constants.loginBtnTextSize),
          ),
        ),
      ),
    );
  }

  imageDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Add Photo!",
        ),
        content: SizedBox(
          height: 130,
          width: 50,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              GestureDetector(
                  child: Card(
                    color: Constants.darkgrey,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () async {
                    takePhoto(ImageSource.camera);
                    Get.back();
                  }),
              GestureDetector(
                child: Card(
                  color: Constants.darkgrey,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose From Gallery",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  takePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              GestureDetector(
                child: Card(
                  color: Constants.buttonRed,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  frontimageDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Add Photo!",
        ),
        content: SizedBox(
          height: 130,
          width: 50,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              GestureDetector(
                  child: Card(
                    color: Constants.darkgrey,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () async {
                    fronttakePhoto(ImageSource.camera);
                    Get.back();
                  }),
              GestureDetector(
                child: Card(
                  color: Constants.darkgrey,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose From Gallery",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  fronttakePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              GestureDetector(
                child: Card(
                  color: Constants.buttonRed,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  backimageDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Add Photo!",
        ),
        content: SizedBox(
          height: 130,
          width: 50,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              GestureDetector(
                  child: Card(
                    color: Constants.darkgrey,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () async {
                    backtakePhoto(ImageSource.camera);
                    Get.back();
                  }),
              GestureDetector(
                child: Card(
                  color: Constants.darkgrey,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Choose From Gallery",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  backtakePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              GestureDetector(
                child: Card(
                  color: Constants.buttonRed,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  takePhoto(ImageSource source) async {
    names = [];
    paths = [];
    baseImg = [];

    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    final File file = File(image!.path);

    log(image.toString());
    log(file.toString());

    try {
      if (image != null) {
        setState(() {
          selectedImage = file;
          String fileName = image.path.toString().split('/').last;
          List<int> imageBytes = selectedImage!.readAsBytesSync();
          var imageB64 = base64Encode(imageBytes);
          baseImg.add(imageB64);
          names.add(fileName);
          paths.add(image.path.toString());
          log('-----image details----');
          log(imageBytes.toString());
          log(imageB64.toString());
          log(imageB64.toString());
          log(baseImg.toString());
          log(names.toString());
          log(paths.toString());
        });
      }
    } catch (e) {
      return e;
    }
  }

  fronttakePhoto(ImageSource source) async {
    frontNames = [];
    frontPaths = [];
    frontbaseimg = [];

    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    final File file = File(image!.path);

    log(image.toString());
    log(file.toString());

    try {
      if (image != null) {
        setState(() {
          frontSelectedImage = file;
          String fileName = image.path.toString().split('/').last;
          List<int> imageBytes = frontSelectedImage!.readAsBytesSync();
          var imageB64 = base64Encode(imageBytes);
          frontbaseimg.add(imageB64);
          frontNames.add(fileName);
          frontPaths.add(image.path.toString());
        });
      }
    } catch (e) {
      return e;
    }
  }

  backtakePhoto(ImageSource source) async {
    backNames = [];
    backPaths = [];
    backbaseImg = [];

    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    final File file = File(image!.path);

    log(image.toString());
    log(file.toString());

    try {
      if (image != null) {
        setState(() {
          backSelectedImage = file;
          String fileName = image.path.toString().split('/').last;
          List<int> imageBytes = backSelectedImage!.readAsBytesSync();
          var imageB64 = base64Encode(imageBytes);
          backbaseImg.add(imageB64);
          backNames.add(fileName);
          backPaths.add(image.path.toString());
        });
      }
    } catch (e) {
      return e;
    }
  }

  makeRegistrationApiCall() async {
    log(teamNameController.text.toString());
    log(
      captainNameController.text.toString(),
    );
    log(Constants.mobNum.toString());
    log(
      ageController.text.toString(),
    );
    log(
      aadharNumController.text.toString(),
    );
    log(
      addressController.text.toString(),
    );
    log(
      panchayathiController.text.toString(),
    );
    log(
      mandalDropdownValue.toString(),
    );
    log(
      districtDropdownValue.toString(),
    );
    log(
      frontPaths[0].toString(),
    );
    log(
      backPaths[0].toString(),
    );
    log(paths[0].toString());
    await ApiService.registerForm(
            "Users/userTeamRegistration",
            teamNameController.text.toString(),
            captainNameController.text.toString(),
            Constants.mobNum.toString(),
            ageController.text.toString(),
            aadharNumController.text.toString(),
            addressController.text.toString(),
            panchayathiController.text.toString(),
            mandalDropdownValue.toString(),
            districtDropdownValue.toString(),
            frontPaths[0].toString(),
            backPaths[0].toString(),
            paths[0].toString())
        .then((success) async {
      setState(() {
        var responseBody = json.decode(success);
        print(responseBody);
        if (responseBody['status'] == true) {
          saveUserRegistrationDetails(responseBody);
          Get.snackbar("Alert", responseBody['message'].toString(),
              overlayBlur: 5,
              backgroundColor: Constants.whiteColor,
              titleText: Text(
                'Alert',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.headerSize),
              ),
              messageText: Text(responseBody['message'].toString()));
          Get.offAll(const SetPin());
          // if (responseBody['teamCount'] == 0) {
          //   Get.offAll(const TeamRegistration());
          // } else {
          //   Get.offAll(const TeamDetails());
          // }

        } else {
          log('errorList--------------');

          var errorList = responseBody['errors'];

          if (errorList['team_captain'] != null) {
            Get.snackbar("Alert", errorList['team_captain'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['team_captain'].toString()));
          } else if (errorList['team_name'] != null) {
            Get.snackbar("Alert", errorList['team_name'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['team_name'].toString()));
          } else if (errorList['captain_mobile'] != null) {
            Get.snackbar("Alert", errorList['captain_mobile'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['captain_mobile'].toString()));
          } else if (errorList['age'] != null) {
            Get.snackbar("Alert", errorList['age'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['age'].toString()));
          } else if (errorList['aadhar'] != null) {
            Get.snackbar("Alert", errorList['aadhar'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['aadhar'].toString()));
          } else if (errorList['address'] != null) {
            Get.snackbar("Alert", errorList['address'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['address'].toString()));
          } else if (errorList['panchayathi'] != null) {
            Get.snackbar("Alert", errorList['panchayathi'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['panchayathi'].toString()));
          } else if (errorList['mandalam'] != null) {
            Get.snackbar("Alert", errorList['mandalam'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['mandalam'].toString()));
          } else if (errorList['district'] != null) {
            Get.snackbar("Alert", errorList['district'].toString(),
                overlayBlur: 5,
                backgroundColor: Constants.whiteColor,
                titleText: Text(
                  'Alert',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Constants.headerSize),
                ),
                messageText: Text(errorList['district'].toString()));
          }
        }
      });
    });
  }

  getMandals() async {
    await ApiService.get("Users/getMandalam").then((success) async {
      setState(() {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        mandalList = responseBody['Data'];
      });
    });
  }

  getDistricts() async {
    await ApiService.get("Users/getDistricts").then((success) async {
      setState(() {
        var responseBody = json.decode(success.body);
        log(responseBody.toString());
        districtList = responseBody['Data'];
      });
    });
  }
}

saveUserRegistrationDetails(resposnseBody) async {
  SharedPreferences registerPrefs = await SharedPreferences.getInstance();

  registerPrefs.setString(
      "teamID", resposnseBody["team"]['team_id'].toString());

  registerPrefs.setString(
      "teamName", resposnseBody["team"]['team_name'].toString());

  registerPrefs.setString(
      "teamCaptain", resposnseBody['team']['team_captain'].toString());

  registerPrefs.setString(
      "captainNumber", resposnseBody['team']['captain_mobile'].toString());

  registerPrefs.setString(
      "loginPIN", resposnseBody['team']['pin'].toString());

  print(registerPrefs.getString('teamID'));
  print(registerPrefs.getString('teamName'));
  print(registerPrefs.getString('teamCaptain'));
  print(registerPrefs.getString('captainNumber'));
}
