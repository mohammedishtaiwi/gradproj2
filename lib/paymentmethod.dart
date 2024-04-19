import 'package:flutter/material.dart';
import 'package:gradproj2/addpaymentwithcard.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

// ignore: camel_case_types
class paymethodpage extends StatefulWidget {
  const paymethodpage({Key? key}) : super(key: key);

  @override
  State<paymethodpage> createState() => _paymethodpageState();
}

// ignore: camel_case_types
class _paymethodpageState extends State<paymethodpage> {
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
          "Payment method",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FloatingActionButton.extended(
            label: const Text(
              "NEXT",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Gilroy'),
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.blueAccent.shade400,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const addpayment(),
                ),
              );
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 124),
              height: 161,
              width: 220,
              child: Image.asset('assets/creditcard.png'),
            ),
          ),
          const SizedBox(height: 71),
          Text(
            "No Card Added Yet",
            style: TextStyle(
                color: notifire.getdarkscolor,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                fontFamily: 'Gilroy'),
          ),
          const SizedBox(height: 8),
          const Text(
            'You don’t added any credit cards',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy'),
          ),
          const Text(
            'yet.Please add the card for transaction',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Gilroy'),
          ),
          //SizedBox(height: 161),
          // Container(
          //   height: 56,
          //   width: double.infinity,
          //   margin: const EdgeInsets.only(top: 135),
          //   padding: const EdgeInsets.only(left: 24, right: 24),
          //   child: FloatingActionButton(
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(14)),
          //     // ignore: sort_child_properties_last
          //     child: const Text("ADD CREDIT CARD",
          //         style:
          //         TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          //     backgroundColor: Colors.blueAccent.shade400,
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => addpayment()),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
