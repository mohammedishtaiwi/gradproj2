import 'package:flutter/material.dart';
import 'package:gradproj2/otpverificationscreen.dart';
import 'package:gradproj2/signinpage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

// ignore: camel_case_types
class _forgetpasswordState extends State<forgetpassword> {
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

  TextEditingController email = TextEditingController();

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
                  builder: (BuildContext context) => const signin(),
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
                          builder: (BuildContext context) => const signin(),
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
            //       onPressed: () {},
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'Forgot',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: notifire.getdarkscolor,
                      fontFamily: 'Gilroy'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('password?',
                    style: TextStyle(
                        fontSize: 32,
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy'))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Don’t worry! Just fill in your email and we’ll\nsend a code to reset your password.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: notifire.greytextColor,
                    fontFamily: 'Gilroy'),
              ),
            ),
            const SizedBox(
              height: 55,
            ),
            TextField(
              controller: email,
              style:
                  TextStyle(color: notifire.getgreycolor, fontFamily: "gilroy"),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: notifire.getdarkscolor, fontFamily: "gilroy"),
                fillColor: Colors.white,
                hintText: 'Enter Your Email',
                labelText: "EMAIL",
                labelStyle: TextStyle(
                    color: notifire.getgreycolor, fontFamily: "gilroy"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: notifire.getgreycolor,
                  ),
                ),
              ),
              // decoration: InputDecoration(
              //   hintText: 'percyjackson@gmail.com',
              //   labelText: "EMAIL",
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(10),
              //     borderSide: BorderSide(
              //       color: Colors.red,
              //       width: 5.0,
              //     ),
              //   ),
              // ),
            ),
            const SizedBox(height: 65),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: FloatingActionButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                // ignore: sort_child_properties_last
                child: const Text('SEND CODE',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Gilroy')),
                backgroundColor: Colors.blueAccent.shade400,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const otp(),
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
