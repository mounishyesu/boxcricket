import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:basic_utils/basic_utils.dart';
import 'package:boxcricket/apiservice/restapi.dart';
import 'package:boxcricket/views/login/login.dart';
import 'package:boxcricket/views/matchschedule/matchschedule.dart';
import 'package:boxcricket/views/signup/signup.dart';
import 'package:boxcricket/views/teamdashboard/teamdetails.dart';
import 'package:boxcricket/views/topstories/TopStories.dart';
import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  Timer? _timer;
  bool readMore = false;
  String capName = "", teamID = "";
  List matchList = [];
  List storiesList = [];
  List featureadList = [];

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
                height: MediaQuery.of(context).size.height * 0.2,
                child: CarouselSlider.builder(
                    disableGesture: true,
                    itemCount: matchList.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                       Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Constants.buttonRed,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child:  matchList.isEmpty?Center(
                            child: Text(
                              'No match data available',
                              style: TextStyle(
                                  color: Constants.whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ):Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    matchList[itemIndex]['match_date']
                                        .toString(),
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
                                          matchList[itemIndex]
                                                  ['match_team_one_name']
                                              .toString()
                                              .substring(0, 3)
                                              .toUpperCase(),
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
                                            Text(
                                                matchList[itemIndex]
                                                        ['match_team_one_name']
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.whiteColor,
                                                  fontSize: 12,
                                                )),
                                            Text(
                                                matchList[itemIndex][
                                                        'match_team_one_mandal']
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.blackColor,
                                                  fontSize: 12,
                                                )),
                                            Text(
                                                matchList[itemIndex]
                                                        ['DummyOne_Team_ID']
                                                    .toString(),
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
                                            Text(
                                                matchList[itemIndex]
                                                        ['match_team_two_name']
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.whiteColor,
                                                  fontSize: 12,
                                                )),
                                            Text(
                                                matchList[itemIndex][
                                                        'match_team_two_mandal']
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Constants.blackColor,
                                                  fontSize: 12,
                                                )),
                                            Text(
                                                matchList[itemIndex]
                                                        ['DummyTwo_Team_ID']
                                                    .toString(),
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
                                          matchList[itemIndex]
                                                  ['match_team_two_name']
                                              .toString()
                                              .substring(0, 3)
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Constants.blackColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: Constants.labelSize * 3,
                              // ),
                              // Container(
                              //   height: 25,
                              //   width: 100,
                              //   decoration: BoxDecoration(
                              //     borderRadius: const BorderRadius.all(
                              //         Radius.circular(50)),
                              //     color: Constants.darkgrey,
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Icon(
                              //         Icons.star,
                              //         color: Constants.buttonRed,
                              //         size: 18,
                              //       ),
                              //       Text(
                              //         "4 WON",
                              //         style: TextStyle(
                              //             color: Constants.whiteColor,
                              //             fontSize: 10),
                              //       ),
                              //     ],
                              //   ),
                              // )
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
                          itemCount: featureadList.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              featureadList.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No Feature Ads available',
                                        style: TextStyle(
                                            color: Constants.whiteColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Image.network(
                                      featureadList[itemIndex]['file_url']
                                          .toString(),
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
                    storiesList.isEmpty
                        ? Container(
                            margin: const EdgeInsets.only(top: 100),
                            alignment: Alignment.center,
                            child: Text(
                              'No stories available',
                              style: TextStyle(
                                  color: Constants.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : SafeArea(
                            bottom: true,
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: storiesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.network(
                                          storiesList[index]['cuisine_file_url']
                                              .toString(),
                                          height: 200,
                                          width: 500,
                                          fit: BoxFit.fill),
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          storiesList[index]['cuisine_name']
                                              .toString(),
                                          style: TextStyle(
                                              color: Constants.darkgrey,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            storiesList[index]['description']
                                                .toString(),
                                            maxLines: readMore ? 10 : 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            padding: const EdgeInsets.all(6),
                                            child: GestureDetector(
                                              child: Text(
                                                readMore
                                                    ? "Read less"
                                                    : "Read more",
                                                style: const TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onTap: () {
                                                log('pressed');
                                                Get.to(const TopStories(),
                                                    arguments: [
                                                      storiesList[index][
                                                              'cuisine_file_url']
                                                          .toString(),
                                                      storiesList[index]
                                                              ['cuisine_name']
                                                          .toString(),
                                                      storiesList[index]
                                                              ['description']
                                                          .toString(),
                                                    ]);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
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
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
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
    getMatchList();
  }

  getMatchList() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    await ApiService.get("Users/getMatchList").then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          matchList = responseBody['Data'];
          log(responseBody.toString());
          log(matchList.toString());
          var teamOneName = matchList[0]['match_team_one_name'];
          var teamOneMandal = matchList[0]['match_team_one_mandal'];
          var teamTwoName = matchList[0]['match_team_two_name'];
          var teamTwoMandal = matchList[0]['match_team_two_mandal'];
          log(teamOneName.toString());
          log(teamOneMandal.toString());
          log(teamTwoName.toString());
          log(teamTwoMandal.toString());
          getStories();
        });
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }

  getStories() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    await ApiService.get("Users/getTopStories").then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          storiesList = responseBody['Data'];
          log(responseBody.toString());
          log(storiesList.toString());
          getFeatureAds();
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }

  getFeatureAds() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    await ApiService.get("Users/getFeatureAdds").then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          featureadList = responseBody['Data'];
          log(responseBody.toString());
          log(featureadList.toString());
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }

  clearData(context) async {
    SharedPreferences registerPrefs = await SharedPreferences.getInstance();
    await registerPrefs.clear();
  }
}
