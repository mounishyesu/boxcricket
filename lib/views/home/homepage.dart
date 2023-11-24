import 'package:boxcricket/views/widgets/constants.dart';
import 'package:boxcricket/views/widgets/responsive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
          title: const Text("Hi Surya!"),
          titleTextStyle: TextStyle(
              fontSize: Constants.loginBtnTextSize,
              color: Constants.blackColor,
              fontWeight: FontWeight.w500),
        ),
        drawer: Container(
          color: Constants.buttonRed,
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
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
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
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurple,
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
                              Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(bottom: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  color: Constants.darkgrey,
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        color: Constants.darkgrey,
                      ),
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
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pretium magna vel leo viverra, vitae tempor nibh imperdiet. Vestibulum luctus risus turpis, in sagittis turpis bibendum et. Curabitur suscipit tempor elit, in egestas velit imperdiet eget. ",
                          style: TextStyle(
                            color: Constants.darkgrey,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
