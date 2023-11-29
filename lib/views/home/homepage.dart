import 'dart:developer';
import 'package:basic_utils/basic_utils.dart';
import 'package:boxcricket/views/login/login.dart';
import 'package:boxcricket/views/matchschedule/matchschedule.dart';
import 'package:boxcricket/views/signup/signup.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/topstories/TopStories.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const HomePage(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const HomePage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool readMore = false;
  String capName = "", teamID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCapName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Constants.buttonRed,
              height: 1.0,
            ),
          ),
          title: Text("Hi ${capName.toString()} !"),
          titleTextStyle: TextStyle(
              fontSize: Constants.loginBtnTextSize,
              color: Constants.blackColor,
              fontWeight: FontWeight.w500),
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          color: Constants.whiteColor,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                    left: 20),
                child: Row(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          Constants.logoImage,
                          height: 100,
                          width: 100,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WELCOME TO SPL',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: Constants.headerSize,
                                fontWeight: FontWeight.bold,
                                color: Constants.buttonRed),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Constants.darkgrey,
                thickness: 2,
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person_pin,
                      size: 30,
                      color: Constants.darkgrey,
                    ),
                    title: Text(
                      'Matches',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Constants.darkgrey),
                    ),
                    onTap: () {
                      Get.to(() => const MatchSchedule());
                    },
                  ),
                  Divider(
                    color: Constants.darkgrey,
                  ),
                  Visibility(
                    visible: teamID.toString().isEmpty ? false : true,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.person_pin,
                            size: 30,
                            color: Constants.darkgrey,
                          ),
                          title: Text(
                            'My Team',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Constants.darkgrey),
                          ),
                          onTap: () {
                            Get.to(() => const TeamDetails());
                          },
                        ),
                        Divider(
                          color: Constants.darkgrey,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.exit_to_app,
                            size: 30,
                            color: Constants.darkgrey,
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Constants.darkgrey),
                          ),
                          onTap: () {
                            /// Close Navigation drawer before
                            clearData(context);
                            Get.offAll(() => const SingnUpPage());
                          },
                        ),
                        Divider(
                          color: Constants.darkgrey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.21,
                child: CarouselSlider.builder(
                    disableGesture: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Constants.buttonRed,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Fri 18, 2023",
                                    style:
                                        TextStyle(color: Constants.whiteColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Constants.defaultPadding,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Constants.whiteColor,
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "SSE",
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Team Name",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.whiteColor,
                                                  fontSize: 12,
                                                )),
                                            Text("Mandal Name",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.blackColor,
                                                  fontSize: 12,
                                                )),
                                            Text("Team ID",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.blackColor,
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Constants.whiteColor,
                                          size: 15,
                                        ),
                                        Icon(Icons.arrow_forward_rounded,
                                            color: Constants.whiteColor,
                                            size: 15),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Team Name",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.whiteColor,
                                                  fontSize: 12,
                                                )),
                                            Text("Mandal Name",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.blackColor,
                                                  fontSize: 12,
                                                )),
                                            Text("Team ID",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.blackColor,
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Constants.whiteColor,
                                            shape: BoxShape.circle),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "SSE",
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Constants.labelSize * 3,
                              ),
                              Container(
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  color: Constants.darkgrey,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Constants.buttonRed,
                                      size: 18,
                                    ),
                                    Text(
                                      "4 WON",
                                      style: TextStyle(
                                          color: Constants.whiteColor,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.95,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Constants.navyBlue,
                    Constants.navyBlue,
                  ],
                )),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Feature Ads",
                            style: TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: CarouselSlider.builder(
                          disableGesture: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Image.asset(
                                Constants.cricImage,
                              ),
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.95,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Top Stories",
                          style: TextStyle(
                              color: Constants.darkgrey,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(Constants.storyImage,
                          height: 200, width: 500, fit: BoxFit.fill),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Story Headline",
                          style: TextStyle(
                              color: Constants.darkgrey,
                              fontWeight: FontWeight.bold),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        children: [
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pretium magna vel leo viverra, vitae tempor nibh imperdiet. Vestibulum luctus risus turpis, in sagittis turpis bibendum et. Curabitur suscipit tempor elit, in egestas velit imperdiet eget. ",
                            maxLines: readMore ? 10 : 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(6),
                            child: GestureDetector(
                              child: Text(
                                readMore ? "Read less" : "Read more",
                                style: const TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                setState(() {
                                  log('pressed');
                                  Get.to(const TopStories());
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  setCapName() async {
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    setState(() {
      if (registerPrefs.getString('teamCaptain').toString() == 'null' ||
          registerPrefs.getString('teamCaptain').toString() == "") {
        capName = "";
        teamID = "";
      } else {
        capName = StringUtils.capitalize(
            registerPrefs.getString('teamCaptain').toString());
        teamID = StringUtils.capitalize(
            registerPrefs.getString('teamID').toString());
        log(capName.toString());
        log(teamID.toString());
      }
    });
  }

  clearData(context) async {
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    await registerPrefs.clear();
  }
}
