import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  String dropdownValue = "";
  var mandalList = [
    {"id": "1", "name": "Palasa"},
    {"id": "2", "name": "Rajam"},
    {"id": "3", "name": "Etcherla"},
    {"id": "4", "name": "Ranastalam"},
    {"id": "5", "name": "Pathapatnam"},
  ];
  TextEditingController teamNameController = TextEditingController();
  TextEditingController captainNameController = TextEditingController();
  TextEditingController captainMobNumController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController aadharNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController panchayatController = TextEditingController();
  List names = [], paths = [], baseImg = [];
  File? image, selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.back(),
        ),
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
                        DottedBorder(
                            child: IconButton(
                                    onPressed: () => imageDialog(),
                                    icon: Constants.cameraIcon,
                                    iconSize: 30,
                                  ),),
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
                        DottedBorder(
                          child: IconButton(
                            onPressed: () => imageDialog(),
                            icon: Constants.cameraIcon,
                            iconSize: 30,
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
                        DottedBorder(
                          child: IconButton(
                            onPressed: () => imageDialog(),
                            icon: Constants.cameraIcon,
                            iconSize: 30,
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
                    controller: panchayatController,
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
                        dropdownValue = newValue.toString();
                        log(dropdownValue);
                      });
                    },
                    items: mandalList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['id'],
                        child: Text(
                          item['name'].toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Constants.gapBetweenFields1,
                ),
                GestureDetector(
                  onTap: () => {
                    if (teamNameController.text.isEmpty ||
                        teamNameController.text.length < 3)
                      {
                        Get.snackbar("Alert", Constants.loginAlertMsg,
                            overlayBlur: 5,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText:
                                Text(Constants.registrationTeamNameAlertMsg)),
                      }
                    else if (captainNameController.text.isEmpty ||
                        captainNameController.text.length < 3)
                      {
                        Get.snackbar("Alert", Constants.loginAlertMsg,
                            overlayBlur: 5,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText:
                                Text(Constants.registrationCapNameAlertMsg)),
                      }
                    else if (captainMobNumController.text.isEmpty ||
                        captainMobNumController.text.length < 10)
                      {
                        Get.snackbar("Alert", Constants.loginAlertMsg,
                            overlayBlur: 5,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText: Text(Constants.loginAlertMsg)),
                      }
                    else if (ageController.text.isEmpty ||
                        ageController.text.length < 2)
                      {
                        Get.snackbar("Alert", Constants.ageAlertMsg,
                            overlayBlur: 5,
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
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText: Text(Constants.aadharAlertMsg)),
                      }
                    else if (addressController.text.isEmpty ||
                        addressController.text.length < 8)
                      {
                        Get.snackbar("Alert", Constants.addressAlertMsg,
                            overlayBlur: 5,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText: Text(Constants.addressAlertMsg)),
                      }
                    else if (panchayatController.text.isEmpty)
                      {
                        Get.snackbar("Alert", Constants.panchayatAlertMsg,
                            overlayBlur: 5,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText: Text(Constants.panchayatAlertMsg)),
                      }
                    else if (dropdownValue.isEmpty)
                      {
                        Get.snackbar("Alert", Constants.mandalAlertMsg,
                            overlayBlur: 5,
                            titleText: Text(
                              'Alert',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Constants.headerSize),
                            ),
                            messageText: Text(Constants.mandalAlertMsg)),
                      }
                    else
                      {
                        log("---------------Details Entere---------------"),
                        log(teamNameController.text.toString()),
                        log(captainNameController.text.toString()),
                        log(captainMobNumController.text.toString()),
                        log(aadharNumController.text.toString()),
                        log(addressController.text.toString()),
                        log(panchayatController.text.toString()),
                        log(dropdownValue.toString()),
                      }
                  },
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: Constants.registrationTextFieldHeight,
                      decoration: BoxDecoration(
                          color: Constants.buttonRed,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        Constants.continueButton,
                        style: TextStyle(
                            color: Constants.buttonTextColor,
                            fontSize: Constants.loginBtnTextSize),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    color: Constants.buttonRed,
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
                  color: Constants.buttonRed,
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
      }
    } catch (e) {
      return e;
    }
  }
}
