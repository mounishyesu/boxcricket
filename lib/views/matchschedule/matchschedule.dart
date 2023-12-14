import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../apiservice/restapi.dart';

class MatchSchedule extends StatefulWidget {
  const MatchSchedule({super.key});

  @override
  State<MatchSchedule> createState() => _MatchScheduleState();
}

class _MatchScheduleState extends State<MatchSchedule> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const MatchScheduleScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const MatchScheduleScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatchScheduleScreen extends StatefulWidget {
  const MatchScheduleScreen({super.key});

  @override
  State<MatchScheduleScreen> createState() => _MatchScheduleScreenState();
}

class _MatchScheduleScreenState extends State<MatchScheduleScreen> {
  Timer? _timer;
  List matchScheduleList = [];
  List matchScheduleInfoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMatchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.matchScheduleHeader),
        titleTextStyle: TextStyle(
            fontSize: Constants.loginBtnTextSize, color: Constants.blackColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_sharp,
            size: Constants.backIconSize,
            color: Constants.backIconColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Constants.singinBgColor,
      body: SafeArea(
        bottom: true,
        child: DataTable2(
            headingTextStyle: TextStyle(
                color: Constants.whiteColor, fontWeight: FontWeight.w400),
            headingRowHeight: 40,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Constants.buttonRed),
            columnSpacing: 2,
            dataRowHeight: 80,
            columns: [
              DataColumn2(
                fixedWidth: MediaQuery.of(context).size.width * 0.45,
                label: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(Constants.teamsText),
                ),
                size: ColumnSize.L,
              ),
              const DataColumn2(
                label: Text('P'),
              ),
              const DataColumn2(
                label: Text('W'),
              ),
              const DataColumn2(
                label: Text('L'),
              ),
              const DataColumn2(
                label: Text('D'),
              ),
              const DataColumn2(
                label: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text('V'),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
                matchScheduleList.length,
                (index) => DataRow(cells: [
                      DataCell(Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Constants.blueGrey),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                matchScheduleList[index]['image'].toString(),
                              ),
                              radius: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    matchScheduleList[index]['team_name']
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Constants.buttonRed,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    matchScheduleList[index]['mandalam']
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Constants.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    matchScheduleList[index]['team_id']
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Constants.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          )
                        ],
                      )),
                      DataCell(Text(
                          matchScheduleList[index]['matchPlayCount'].toString(),
                          style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))),
                      DataCell(Text(
                          matchScheduleList[index]['matchWinCount'].toString(),
                          style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))),
                      DataCell(Text(
                          matchScheduleList[index]['matchLossCount'].toString(),
                          style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))),
                      DataCell(Text(
                          matchScheduleList[index]['drawCount'].toString(),
                          style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))),
                      DataCell(IconButton(
                        onPressed: () {
                          log(matchScheduleList[index]['team_id'].toString());
                          getMatchScheduleInfo(matchScheduleList[index]['team_id'].toString());
                          Future.delayed(const Duration(seconds: 2), () async {
                            setState(() {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Constants.whiteColor,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      height: MediaQuery.of(context).size.height *
                                          0.8,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      alignment: Alignment.center,
                                                      margin:
                                                      const EdgeInsets.only(
                                                        left: 30,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Constants
                                                                .blueGrey),
                                                        color: Constants
                                                            .singinBgColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child:CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                          matchScheduleList[index]['image'].toString(),
                                                        ),
                                                        radius: 30,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Constants.labelSize,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          matchScheduleList[index]['team_name'].toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: Constants
                                                                  .loginBtnTextSize),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                    onTap: () => Get.back(),
                                                    child:
                                                    const Icon(Icons.clear)),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.45,
                                              child: SafeArea(
                                                bottom: true,
                                                child: DataTable2(
                                                    headingTextStyle: TextStyle(
                                                        color:
                                                        Constants.whiteColor,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                    headingRowHeight: 40,
                                                    headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith(
                                                            (states) =>
                                                        Constants
                                                            .buttonRed),
                                                    columnSpacing: 2,
                                                    dataRowHeight: 80,
                                                    // horizontalMargin: 12,
                                                    columns: [
                                                      DataColumn2(
                                                        fixedWidth:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.45,
                                                        label: const Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              left: 50.0),
                                                          child: Text("OPPONENT"),
                                                        ),
                                                        size: ColumnSize.L,
                                                      ),
                                                      const DataColumn2(
                                                        label: Text('DATE'),
                                                      ),
                                                      const DataColumn2(
                                                        label: Text('RESULT'),
                                                      ),
                                                    ],
                                                    rows: List<DataRow>.generate(
                                                        matchScheduleInfoList.length,
                                                            (index) => DataRow(
                                                            cells: [
                                                              DataCell(Row(
                                                                children: [
                                                                  Container(
                                                                    alignment: Alignment.center,
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(color: Constants.blueGrey),
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                    child: CircleAvatar(
                                                                      backgroundImage: NetworkImage(
                                                                        matchScheduleInfoList[index]['opponent_image'].toString(),
                                                                      ),
                                                                      radius: 30,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                    100,
                                                                    child:
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(matchScheduleInfoList[index]['opponent'].toString(),
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(color: Constants.buttonRed, fontSize: 12, fontWeight: FontWeight.w500)),
                                                                        Text(
                                                                            matchScheduleInfoList[index]['opponent_manadalam'].toString(),
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(color: Constants.blackColor, fontSize: 12, fontWeight: FontWeight.w500)),
                                                                        Text(matchScheduleInfoList[index]['opponent_id'].toString(),
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(color: Constants.blackColor, fontSize: 12, fontWeight: FontWeight.w500)),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                              DataCell(Text(
                                                                  matchScheduleInfoList[index]['date'].toString(),
                                                                  style: TextStyle(
                                                                      color: Constants
                                                                          .blackColor,
                                                                      fontSize:
                                                                      12,
                                                                      fontWeight:
                                                                      FontWeight.w500))),
                                                              DataCell(Text(
                                                                matchScheduleInfoList[index]['comment'].toString(),
                                                                style: TextStyle(
                                                                    color: Constants
                                                                        .blackColor,
                                                                    fontSize:
                                                                    12,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                                maxLines: 3,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              )),
                                                            ]))),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                        ],
                                      ));
                                },
                              );
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.remove_red_eye,
                          size: 20,
                        ),
                      )),
                    ]))),
      ),
    );
  }

  getMatchSchedule() async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    var encodeBody = jsonEncode({"team_id": "team"});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("Users/getMatchScheduleInformation", encodeBody)
        .then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          log('----------------------------------responseBody-------------------------------------');
          log(responseBody.toString());
          log('-----------------------------------------------------------------------');
          matchScheduleList = responseBody['Data'];
          log('----------------------------------matchScheduleList-------------------------------------');
          log(matchScheduleList.toString());
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }

  getMatchScheduleInfo(teamID) async {
    Constants.easyLoader();
    EasyLoading.show(
      status: "Loading . . .",
    );
    var encodeBody = jsonEncode({"team_id": teamID.toString()});
    log('----------encodeBody-------------');
    log(encodeBody);
    log('-----------------------');
    await ApiService.post("Users/getTeamScheduleMatches", encodeBody)
        .then((success) {
      if (success.statusCode == 200) {
        EasyLoading.addStatusCallback((status) {
          if (status == EasyLoadingStatus.dismiss) {
            _timer?.cancel();
          }
        });
        setState(() {
          var responseBody = json.decode(success.body);
          log('----------------------------------responseBody-------------------------------------');
          log(responseBody.toString());
          log('-----------------------------------------------------------------------');
          matchScheduleInfoList = responseBody['Data'];
          log('----------------------------------matchScheduleInfoList-------------------------------------');
          log(matchScheduleInfoList.toString());
        });
        EasyLoading.showSuccess("Loading Success");
      } else {
        EasyLoading.showInfo("Loading Failed");
      }
    });
  }
}
