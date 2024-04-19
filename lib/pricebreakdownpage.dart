// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gradproj2/confirmation.dart';
// ignore: unused_import
import 'package:gradproj2/selectflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

class pricebreakdown extends StatefulWidget {
  const pricebreakdown({Key? key}) : super(key: key);

  @override
  State<pricebreakdown> createState() => _pricebreakdownState();
}

class _pricebreakdownState extends State<pricebreakdown> {
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
          "Price breakdown",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontFamily: 'Gilroy',
              fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        height: 103,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            color: notifire.bottomnavigationbarbacground),
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
                      builder: (context) => const confirmpage(),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total price",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy',
                        fontSize: 20),
                  ),
                  Text(
                    "\$650",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy',
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Divider(thickness: 1),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Economy",
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Gilroy',
                            fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "1 adult",
                        style: TextStyle(
                            color: Color(0xffADB3B8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    "\$300",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: notifire.getdarkscolor,
                        fontSize: 16,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Seat selection",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 14),
                  ),
                  Text(
                    "\$60",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cabin bag (3kg)",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 14),
                  ),
                  Text(
                    "\$30",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Check in (25kg)",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 14),
                  ),
                  Text(
                    "\$180",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Xcover protection",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 14),
                  ),
                  Text(
                    "\$10",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Taxes",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 14),
                  ),
                  Text(
                    "\$30",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 14),
                  ),
                  Text(
                    "\$00",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Divider(thickness: 1),
            // SizedBox(
            //   //height: 53,
            //   width: 375,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(right: 42, top: 17),
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
            //               // Navigator.of(context).push(
            //               //   MaterialPageRoute(
            //               //     builder: (BuildContext context) =>
            //               //     const baordingpasspage(),
            //               //   ),
            //               // );
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
