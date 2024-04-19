import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradproj2/forgetpasswordscreen.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomnavigationbar.dart';

// ignore: camel_case_types
class otp extends StatefulWidget {
  const otp({Key? key}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

// ignore: camel_case_types
class _otpState extends State<otp> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  formatedTime(timeinsecond) {
    int sec = timeinsecond % 60;
    // int min = (timeinsecond / 60).floor();
    //String minute = min.toString().length<=1?"0$min":"$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    // ignore: unnecessary_string_interpolations
    return "$second";
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            // isLoading = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  // ignore: unused_field
  Timer? _timer;
  int _start = 60;

  // bool isLoading = false;
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
                  builder: (BuildContext context) => const forgetpassword(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: notifire.backbuttonborderColor),
                    borderRadius: BorderRadius.circular(16)),
                // decoration: BoxDecoration(
                //   image:DecorationImage(image: AssetImage("assets/arrrrrrrrrow.png"),),
                //   borderRadius: BorderRadius.circular(16),
                // ),
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
                              const forgetpassword(),
                        ),
                      );
                    },
                  ),
                ),
                // child: IconButton(
                //   icon: const Icon(
                //     Icons.arrow_back_ios_new_outlined,
                //   ),
                //   iconSize: 20,
                //   color: Colors.black,
                //   onPressed: () {
                //     Navigator.of(context).pop(
                //       MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //         const filtershortdetail(),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          children: [
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     height: 48,
            //     width: 48,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(16),
            //         border: Border.all(color: Colors.grey.shade100)),
            //     alignment: Alignment.center,
            //     child: IconButton(
            //       icon: Icon(
            //         Icons.arrow_back_ios_new_outlined,
            //       ),
            //       iconSize: 20,
            //       color: Colors.black,
            //       onPressed: () {
            //         Navigator.of(context).pop(
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => otp(),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'Verification',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      fontFamily: 'Gilroy',
                      color: notifire.getdarkscolor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'code!',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'We sent you a verification code to your',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: notifire.greytextColor,
                    fontFamily: 'Gilroy'),
              ),
            ),
            Row(
              children: [
                Text(
                  'email',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: notifire.greytextColor,
                      fontFamily: 'Gilroy'),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'plabonux@gmail.com',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy'),
                ),
              ],
            ),
            const SizedBox(height: 52),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 58,
                    width: 64,
                    child: TextFormField(
                      style: TextStyle(
                          color: notifire.getgreycolor, fontFamily: "gilroy"),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: notifire.getgreycolor, fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 64,
                    child: TextFormField(
                      style: TextStyle(
                          color: notifire.getgreycolor, fontFamily: "gilroy"),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: notifire.getgreycolor, fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        //   borderSide: BorderSide(
                        //     color: Colors.red,
                        //     width: 5.0,
                        //   ),
                        // ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 64,
                    child: TextFormField(
                      style: TextStyle(
                          color: notifire.getgreycolor, fontFamily: "gilroy"),
                      showCursor: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: notifire.getgreycolor, fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    width: 64,
                    child: TextFormField(
                      style: TextStyle(
                          color: notifire.getgreycolor, fontFamily: "gilroy"),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: notifire.getgreycolor, fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            Row(
              children: [
                Text(
                  'Resend:',
                  style: TextStyle(
                      color: notifire.greytextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Gilroy'),
                ),
                const SizedBox(width: 7),
                Text(
                  formatedTime(_start) + 's'.toString(),
                  style: TextStyle(
                      color: notifire.getdarkscolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Gilroy'),
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: FloatingActionButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                // ignore: sort_child_properties_last
                child: const Text('SUBMIT',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Gilroy')),
                backgroundColor: Colors.blueAccent.shade400,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const BottomNav(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
