import 'package:flutter/material.dart';
import 'package:gradproj2/securecheckout.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

class
// ignore: camel_case_types
    addpayment extends StatefulWidget {
  const addpayment({Key? key}) : super(key: key);

  @override
  State<addpayment> createState() => _addpaymentState();
}

// ignore: camel_case_types
class _addpaymentState extends State<addpayment> {
  final nameoncard = TextEditingController();
  final cardnumber = TextEditingController();
  final expirydate = TextEditingController();
  final cvc = TextEditingController();
  bool value = false;

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
                alignment: Alignment.center,
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
              ),
            ),
          ),
        ),
        title: Text(
          "Add payments",
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
              "ADD CARD",
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
                  builder: (BuildContext context) => const checkoutpage(),
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
              child: TextField(
                controller: nameoncard,
                style: TextStyle(
                    color: notifire.getgreycolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                  fillColor: Colors.white,
                  hintText: 'Enter Your Name on Card',
                  labelText: "NAME ON CARD",
                  labelStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: TextField(
                controller: cardnumber,
                style: TextStyle(
                    color: notifire.getgreycolor, fontFamily: "gilroy"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: notifire.getgreycolor,
                    ),
                  ),
                  hintStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                  fillColor: Colors.white,
                  hintText: 'Enter Your Card Number',
                  labelText: "CARD NUMBER",
                  labelStyle: TextStyle(
                      color: notifire.getdarkscolor, fontFamily: "gilroy"),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 58,
                  width: 180,
                  padding: const EdgeInsets.only(left: 24),
                  child: TextField(
                    controller: expirydate,
                    style: TextStyle(
                        color: notifire.getgreycolor, fontFamily: "gilroy"),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      fillColor: Colors.white,
                      hintText: 'Expiry date',
                      labelText: "EXPIRY DATE",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 24),
                  height: 58,
                  width: 180,
                  child: TextField(
                    controller: cvc,
                    style: TextStyle(
                        color: notifire.getgreycolor, fontFamily: "gilroy"),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      fillColor: Colors.white,
                      hintText: 'cvc',
                      labelText: "CVC",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Row(
                children: [
                  SizedBox(
                    child: Checkbox(
                      splashRadius: 0,
                      side: const BorderSide(color: Colors.grey),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      // ignore: unnecessary_this
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: 0),
                      value: value,
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    'Save your card information',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff9299A0),
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            //Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 24,right: 24,bottom: 20),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: FloatingActionButton(
            //       elevation: 0,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12)),
            //       // ignore: sort_child_properties_last
            //       child: const Text('ADD CARD',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400, fontSize: 18)),
            //       backgroundColor: Colors.blueAccent.shade400,
            //       onPressed: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //               builder: (BuildContext context) => checkoutpage()),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
