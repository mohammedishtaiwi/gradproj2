// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/searchflightroundtripssearchbar.dart';
import 'package:gradproj2/selectflightfilterandshort.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selectflight extends StatefulWidget {
  const selectflight({Key? key}) : super(key: key);

  @override
  State<selectflight> createState() => _selectflightState();
}

class _selectflightState extends State<selectflight> {
  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.backgroundallscreenColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const searchflightroundtrip(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 8),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: notifire.backbuttonborderColor),
                    borderRadius: BorderRadius.circular(16)),
                // ignore: sort_child_properties_last
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: notifire.backbuttoniconColor,
                    ),
                    iconSize: 14,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const searchflightroundtrip(),
                        ),
                      );
                    },
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            height: 36,
            width: 36,
            margin: const EdgeInsets.only(right: 12),
            alignment: Alignment.center,
            child: IconButton(
              icon: Image.asset(
                'assets/settingsselect.png',
                scale: 2,
              ),
              // iconSize: 24,
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const filterandshortmain(),
                  ),
                );
              },
            ),
          ),
        ],
        // centerTitle: true,
        backgroundColor: notifire.backgroundallscreenColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Search flight",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontFamily: 'Gilroy',
              fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DEA',
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 112,
                        child: Image.asset('assets/selectflight.png'),
                      ),
                      const Text(
                        '1h 30 Min',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontFamily: 'Gilroy'),
                      ),
                    ],
                  ),
                  Text(
                    'LAH',
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dubai',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontFamily: 'Gilroy'),
                  ),
                  Text(
                    'Lahore',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 23.47,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const filtershortdetail(),
                    ),
                  );
                },
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: notifire.notificationbackground,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Image.asset(
                                              'assets/emirates.png'),
                                        ),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        const Text(
                                          "Emirates",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        const SizedBox(
                                          width: 72,
                                        ),
                                        const Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "BH07",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "\$120",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: notifire.getdarkscolor,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "10:40am",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: notifire.getdarkscolor,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          //color: Colors.indigo.shade50,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: SizedBox(
                                        height: 6,
                                        width: 6,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 24,
                                              child: LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  return Flex(
                                                    // ignore: sort_child_properties_last
                                                    children: List.generate(
                                                      (constraints.constrainWidth() /
                                                              10)
                                                          .floor(),
                                                      (index) => SizedBox(
                                                        height: 2,
                                                        width: 5,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              color: notifire
                                                                  .backbuttonborderColor),
                                                        ),
                                                      ),
                                                    ),
                                                    direction: Axis.horizontal,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  );
                                                },
                                              ),
                                            ),
                                            Center(
                                              child: Transform.rotate(
                                                angle: 1.5,
                                                child: const Icon(
                                                  Icons.local_airport,
                                                  color: Colors.amber,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          // color: Colors.indigo.shade50,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: SizedBox(
                                        height: 6,
                                        width: 6,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Text(
                                      "12:50am",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: notifire.getdarkscolor,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 19,
                                      width: 43,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(21),
                                          color:
                                              notifire.ticketdecorationcolor),
                                      child: const Center(
                                        child: Text(
                                          "DEA",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 19,
                                      width: 43,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(21),
                                          color:
                                              notifire.ticketdecorationcolor),
                                      child: const Center(
                                        child: Text(
                                          "LAH",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Column(
                                children: [
                                  Container(
                                    color: notifire.notificationbackground,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 15,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(15),
                                                        bottomRight:
                                                            Radius.circular(
                                                                15)),
                                                color: notifire
                                                    .backgroundallscreenColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                return Flex(
                                                  // ignore: sort_child_properties_last
                                                  children: List.generate(
                                                    (constraints.constrainWidth() /
                                                            18)
                                                        .floor(),
                                                    (index) => SizedBox(
                                                      height: 2,
                                                      width: 10,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color: notifire
                                                                .backbuttonborderColor),
                                                      ),
                                                    ),
                                                  ),
                                                  direction: Axis.horizontal,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 15,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                ),
                                                color: notifire
                                                    .backgroundallscreenColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 26,
                                          width: 108,
                                          decoration: BoxDecoration(
                                            color:
                                                notifire.ticketdecorationcolor2,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                'May 30, 2021',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 26,
                                          width: 108,
                                          decoration: BoxDecoration(
                                            color:
                                                notifire.ticketdecorationcolor2,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.watch_later_outlined,
                                                size: 19,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 7.83,
                                              ),
                                              Text(
                                                '1h 40 Min',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
