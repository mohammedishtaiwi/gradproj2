import 'package:flutter/material.dart';
import 'package:gradproj2/addtraveller.dart';
import 'package:gradproj2/selectflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class filtershortdetail extends StatefulWidget {
  const filtershortdetail({Key? key}) : super(key: key);

  @override
  State<filtershortdetail> createState() => _filtershortdetailState();
}

// List icons = ["assets/"];
// List text1 = ["assets/"];
// List text2 = ["assets/"];

// ignore: camel_case_types
class _filtershortdetailState extends State<filtershortdetail> {
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
                  builder: (BuildContext context) => const selectflight(),
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
                              const selectflight(),
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
          "Details",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      bottomNavigationBar: Container(
        height: 103,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: notifire.bottomnavigationbarbacground,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(
                        color: Color(0xff717171),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                  Text(
                    "\$450",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const addtraveller(),
                    ),
                  );
                },
                child: Container(
                  width: 173,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xff1F75EC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "CONFIRM",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                          child: Image.asset('assets/flightdetail.png')),
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
              height: 31.47,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  'Saturday. December 25, 2021',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff9299A0),
                      fontFamily: 'Gilroy'),
                ),
              ),
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 288,
                decoration: BoxDecoration(
                  color: notifire.notificationbackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Flight Emirates',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: notifire.getdarkscolor,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 18),
                          child: SizedBox(
                            height: 44,
                            width: 44,
                            child:
                                Image.asset('assets/Emirates_Airlines 2.png'),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'EY71',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff848D94),
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                          thickness: 1, color: notifire.backbuttonborderColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          SizedBox(
                            height: 120,
                            child: VerticalDivider(
                              color: notifire.backbuttonborderColor,
                              width: 23,
                              thickness: 2,
                              indent: 10,
                              endIndent: 10,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 48),
                              child: Transform.rotate(
                                angle: 0,
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset('assets/planedivider.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 10,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 11,
                                  width: 11,
                                  child:
                                      Image.asset('assets/detailsreturn.png'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Non-stop',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff848D94),
                                      fontSize: 12,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2:35 PM',
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Abu Dhabi International',
                                  style: TextStyle(
                                      color: Color(0xff848D94),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(height: 33),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '6:12 PM',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'London International',
                                      style: TextStyle(
                                          color: Color(0xff848D94),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: SizedBox(
                        height: 39,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gate',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff848D94),
                                      fontSize: 11,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'B7',
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: notifire.backbuttonborderColor,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Flight Number',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff848D94),
                                      fontSize: 11,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'EY71',
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: notifire.backbuttonborderColor,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Class',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff848D94),
                                      fontSize: 11,
                                      fontFamily: 'Gilroy'),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'Economy',
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 10,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    minLeadingWidth: 15,
                    leading: SizedBox(
                      height: 18,
                      width: 20,
                      child: Image.asset('assets/Bag 2.png'),
                    ),
                    title: const Text(
                      "Cabin bag",
                      style: TextStyle(
                          color: Color(0xff768089),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                    trailing: Text(
                      "\$60 up to 4 kgs",
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 10,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    minLeadingWidth: 15,
                    leading: SizedBox(
                      height: 18,
                      width: 20,
                      child: Image.asset('assets/Location.png'),
                    ),
                    title: const Text(
                      "Check in",
                      style: TextStyle(
                          color: Color(0xff768089),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                    trailing: Text(
                      "\$78 up to 10 kgs",
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 10,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    minLeadingWidth: 15,
                    leading: SizedBox(
                      height: 18,
                      width: 20,
                      child: Image.asset('assets/cancle.png'),
                    ),
                    title: const Text(
                      "Cancellation",
                      style: TextStyle(
                          color: Color(0xff768089),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                    trailing: Text(
                      'Refundable',
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy',
                          fontSize: 12),
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 10,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    minLeadingWidth: 15,
                    leading: SizedBox(
                      height: 18,
                      width: 20,
                      child: Image.asset('assets/Calendardetailselect.png'),
                    ),
                    title: const Text(
                      "Date change",
                      style: TextStyle(
                          color: Color(0xff768089),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                    trailing: Text(
                      "Fee starting \$45",
                      style: TextStyle(
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy',
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            //const SizedBox(height: 12,),
            //const Divider(thickness: 1),
            // SizedBox(
            //   height: 53,
            //   width: 375,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(right: 42, top: 17,left: 24),
            //             child: Row(
            //               children: const [
            //                 Text(
            //                   "Price",
            //                   style: TextStyle(
            //                       color: Color(0xff717171),
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(height: 5),
            //           Row(
            //             children: const [
            //               Text(
            //                 '\$450',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w600, fontSize: 30),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 17),
            //         child: SizedBox(
            //           height: 56,
            //           width: 173,
            //           child: FloatingActionButton(
            //             elevation: 0,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(14)),
            //             // ignore: sort_child_properties_last
            //             child: const Text('CONFIRM',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w600, fontSize: 16)),
            //             backgroundColor: Colors.blueAccent.shade400,
            //             onPressed: () {
            //               Navigator.of(context).push(
            //                 MaterialPageRoute(
            //                   builder: (BuildContext context) =>
            //                       const addtraveller(),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
