import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

// ignore: camel_case_types
class baordingpasspage extends StatefulWidget {
  const baordingpasspage({Key? key}) : super(key: key);

  @override
  State<baordingpasspage> createState() => _baordingpasspageState();
}

// ignore: camel_case_types
class _baordingpasspageState extends State<baordingpasspage> {
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.backgroundallscreenColor,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) => const filtershortdetail(),
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
                              const filtershortdetail(),
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
        title: Text(
          "Boarding pass",
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
                          child: Image.asset('assets/selectflight.png')),
                      const Text(
                        '1h 30 Min',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gilroy',
                            color: Colors.grey),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Dubai',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy',
                        color: Colors.grey),
                  ),
                  Text(
                    'Lahore',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy',
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 27.47),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Container(
                      width: double.infinity,
                      height: 573,
                      decoration: BoxDecoration(
                        color: notifire.notificationbackground,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 75,
                                      width: 75,
                                      child: Image.asset(
                                        "assets/Emirates_Airlines 2.png",
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        'Ticket price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Gilroy',
                                          fontSize: 12,
                                          color: Color(0xffAEB4B9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Text(
                                        '\$567',
                                        style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy',
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      'assets/boardingpassmap.png',
                                      color: notifire.mapofboardingpass,
                                      scale: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Flex(
                                // ignore: sort_child_properties_last
                                children: List.generate(
                                  (constraints.constrainWidth() / 18).floor(),
                                  (index) => SizedBox(
                                    height: 1,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: notifire.backbuttonborderColor,
                                      ),
                                    ),
                                  ),
                                ),
                                direction: Axis.horizontal,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Flight date',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy',
                                          color: Color(0xffAEB4B9)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sun, Feb 04',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Seat',
                                      style: TextStyle(
                                          color: Color(0xffAEB4B9),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'G4T6',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Class',
                                      style: TextStyle(
                                          color: Color(0xffAEB4B9),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Buisness',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Boarding time',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy',
                                          color: Color(0xffAEB4B9)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '8:00 am',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Flight no',
                                      style: TextStyle(
                                          color: Color(0xffAEB4B9),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'KC43',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Arrive',
                                      style: TextStyle(
                                          color: Color(0xffAEB4B9),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Mon, Feb 05',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Column(
                            children: [
                              Container(
                                color: notifire.notificationbackground,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 20,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
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
                                                  height: 1,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: notifire
                                                            .backbuttonborderColor),
                                                  ),
                                                ),
                                              ),
                                              direction: Axis.horizontal,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 20,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                            color: notifire
                                                .backgroundallscreenColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Submit at Registration',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy',
                                fontSize: 14,
                                color: notifire.getdarkscolor),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: 'https://pub.dev/packages/barcode_widget,',
                            style: const TextStyle(color: Colors.transparent),
                            width: 213,
                            height: 80,
                            // backgroundColor: notifire.notificationbackground1,
                            color: notifire.getdarkscolor,
                          ),
                          // SizedBox(
                          //     height: 80,
                          //     width: 213,
                          //     child: Image.asset(
                          //         "assets/barcodeboardingpass.png")),
                          const SizedBox(
                            height: 4,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff1F75EC),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Download',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy',
                                color: Color(0xff1F75EC),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
