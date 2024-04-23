// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gradproj2/apicontroller.dart';
import 'package:gradproj2/apiwrapper.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  bool _isVisible = false;

  @override
  void initState() {
    userlogin();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
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
      //resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 18,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Hello,',
                    style: TextStyle(
                        fontSize: 30,
                        color: notifire.getdarkscolor,
                        fontFamily: 'Gilroy'),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'There',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your information below to get\nstarted on your trips",
                  style: TextStyle(
                      fontSize: 18,
                      color: notifire.greytextColor,
                      fontFamily: 'Gilroy'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: fullname,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        fillColor: Colors.white,
                        hintText: 'Enter Your full name',
                        labelText: "FULL NAME",
                        labelStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                        // decoration: InputDecoration(
                        //   hintText: 'percy jackson',
                        //   labelText: "FULL NAME",
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide: const BorderSide(
                        //       color: Colors.red,
                        //       width: 5.0,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: email,
                      style: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        fillColor: Colors.white,
                        hintText: 'Enter Your Email',
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                        // decoration: InputDecoration(
                        //   hintText: 'percy jackson',
                        //   labelText: "FULL NAME",
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10),
                        //     borderSide: const BorderSide(
                        //       color: Colors.red,
                        //       width: 5.0,
                        //     ),
                        //   ),
                        // ),
                      ),
                      // decoration: InputDecoration(
                      //   hintText: 'i.e,percyjackson@gmail.com',
                      //   labelText: "EMAIL",
                      //   border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //     borderSide: const BorderSide(
                      //       color: Colors.red,
                      //       width: 5.0,
                      //     ),
                      //   ),
                      // ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: _isVisible,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
                        ),
                        hintText: "Enter Your Password",
                        hintStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: notifire.getgreycolor,
                          ),
                        ),
                        // hintText: 'Enter Your Password',
                        // labelText: "PASSWORD",
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: const BorderSide(
                        //     color: Colors.red,
                        //     width: 5.0,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: 'Sign-up',
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text('SIGN UP',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Gilroy')),
                    backgroundColor: Colors.blueAccent.shade400,
                    autofocus: true,
                    onPressed: () async {
                      var body = {
                        "name": fullname.text,
                        "email": email.text,
                        "password": password.text,
                        "mobile": "7041494098",
                        "ccode": "+91",
                        "refercode": ""
                      };
                      apiwrapper.datapost(body);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
