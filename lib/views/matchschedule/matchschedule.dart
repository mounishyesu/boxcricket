import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: GestureDetector(
          onTap: () {
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
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                        left: 30,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Constants.blueGrey),
                                        color: Constants.singinBgColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        Constants.logoImage,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Constants.labelSize,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Seekol Team",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  Constants.loginBtnTextSize),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const Icon(Icons.clear)),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: SafeArea(
                                bottom: true,
                                child: DataTable2(
                                    headingTextStyle: TextStyle(
                                        color: Constants.whiteColor,
                                        fontWeight: FontWeight.w400),
                                    headingRowHeight: 40,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Constants.buttonRed),
                                    columnSpacing: 8,
                                    dataRowHeight: 80,
                                    // horizontalMargin: 12,
                                    columns: [
                                      DataColumn2(
                                        fixedWidth:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        label: const Padding(
                                          padding: EdgeInsets.only(left: 50.0),
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
                                        10,
                                        (index) => DataRow(cells: [
                                              DataCell(
                                                  Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Constants.buttonRed,
                                                        shape: BoxShape.circle),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "SSE",
                                                      style: TextStyle(
                                                          color: Constants
                                                              .whiteColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Team Name",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Constants
                                                                    .buttonRed,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text("Mandal Name",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Constants
                                                                    .blackColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text("Team ID",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Constants
                                                                    .blackColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                              DataCell(Text('10 NOV',
                                                  style: TextStyle(
                                                      color:
                                                          Constants.blackColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                              DataCell(Text(
                                                'This team won by 9 wickets',
                                                style: TextStyle(
                                                    color: Constants.blackColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
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
          },
          child: DataTable2(
              headingTextStyle: TextStyle(
                  color: Constants.whiteColor, fontWeight: FontWeight.w400),
              headingRowHeight: 40,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Constants.buttonRed),
              columnSpacing: 8,
              dataRowHeight: 80,
              // horizontalMargin: 12,
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
                  label: Text('V'),
                ),
              ],
              rows: List<DataRow>.generate(
                  10,
                  (index) => DataRow(cells: [
                        DataCell(Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Constants.buttonRed,
                                  shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: Text(
                                "SSE",
                                style: TextStyle(
                                    color: Constants.whiteColor,
                                    fontWeight: FontWeight.w600),
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
                                  Text("Team Name",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Constants.buttonRed,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  Text("Mandal Name",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Constants.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  Text("Team ID",
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
                        DataCell(Text('10',
                            style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500))),
                        DataCell(Text('4',
                            style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500))),
                        DataCell(Text('3',
                            style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500))),
                        DataCell(Text('1',
                            style: TextStyle(
                                color: Constants.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500))),
                        const DataCell(
                          Icon(
                            Icons.remove_red_eye,
                            size: 20,
                          ),
                        ),
                      ]))),
        ),
      ),
    );
  }
}
