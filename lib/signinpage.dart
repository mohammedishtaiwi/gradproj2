import 'package:gradproj2/apiwrapper.dart';
import 'package:gradproj2/bottomnavigationbar.dart';

import 'package:gradproj2/forgetpasswordscreen.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MaterialApp(
      home: signin(),
    ),
  );
}

// ignore: camel_case_types
class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

// ignore: camel_case_types
class _signinState extends State<signin> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool value = false;
  bool _isVisible = false;

  //bool _isPasswordEightCharacters = false;
  //bool _hasPasswordOneNumber = false;

  // onPasswordChanged(String password1) {
  //   //final numericRegex = RegExp(r'[0-9]');
  //
  //   setState(() {
  //     //_isPasswordEightCharacters = false;
  //     //if (password1.length >= 8) _isPasswordEightCharacters = true;
  //
  //     //_hasPasswordOneNumber = false;
  //     //if (numericRegex.hasMatch(password1)) _hasPasswordOneNumber = true;
  //   });
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
      //resizeToAvoidBottomInset: false,
      backgroundColor: notifire.backgroundallscreenColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Welcome back,",
                    style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 0,
                        fontFamily: 'Gilroy',
                        color: notifire.getdarkscolor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Percy",
                    style: TextStyle(
                        fontSize: 35,
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: email,
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
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
                              color: notifire.getdarkscolor,
                              fontFamily: "gilroy"),
                          fillColor: Colors.white,
                          hintText: 'Enter Your Email',
                          labelText: "EMAIL",
                          labelStyle: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: "gilroy"),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      TextField(
                        style: TextStyle(
                            color: notifire.getdarkscolor,
                            fontFamily: "gilroy"),
                        controller: password,
                        obscureText: _isVisible,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
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
                          hintText: 'Enter Your Password',
                          hintStyle: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: "gilroy"),
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(
                              color: notifire.getdarkscolor,
                              fontFamily: "gilroy"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: notifire.getgreycolor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Row(
                        children: [
                          Checkbox(
                            side: const BorderSide(color: Colors.grey),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            // ignore: unnecessary_this
                            value: this.value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ),
                          const Text(
                            "RememberMe",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                      TextButton(
                        child: Text(
                          "Forgetpassword?",
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              color: notifire.getdarkscolor,
                              fontFamily: 'Gilroy'),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const forgetpassword(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: FloatingActionButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      // ignore: sort_child_properties_last
                      child: const Text('SIGN IN',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Gilroy')),
                      backgroundColor: Colors.blueAccent.shade400,
                      onPressed: () {
                        var body = {
                          "email": email.text,
                          "password": password.text,
                        };
                        apiwrapper.userlogin(body);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BottomNav(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: Text(
                      "Or",
                      style: TextStyle(
                          fontFamily: 'Gilroy', color: notifire.greytextColor),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 66,
                          width: 66,
                          decoration: const BoxDecoration(),
                          child: FloatingActionButton(
                            elevation: 0,
                            // ignore: sort_child_properties_last
                            child: SizedBox(
                              height: 33,
                              width: 33,
                              child: Image.asset('assets/g.png'),
                            ),
                            backgroundColor: notifire.notificationbackground1,
                            splashColor: null,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 66,
                          width: 66,
                          // ignore: duplicate_ignore
                          child: FloatingActionButton(
                            elevation: 0,
                            // ignore: sort_child_properties_last
                            child: SizedBox(
                                height: 33,
                                width: 33,
                                child:
                                    Image.asset('assets/Facebookloogin.png')),
                            backgroundColor: notifire.notificationbackground1,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 66,
                          width: 66,
                          child: FloatingActionButton(
                            elevation: 0,
                            // ignore: sort_child_properties_last
                            child: SizedBox(
                                height: 33,
                                width: 33,
                                child: Image.asset('assets/ia.png',
                                    color: notifire.apple)),
                            backgroundColor: notifire.notificationbackground1,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
// callLoginApi() {
//   final service = ApiServices();
//   service.Apiservice(
//     {
//       "email": email.text,
//       "password": password.text,
//     },
//   ).then(
//     (value) {
//       if (value.error != null) {
//         print("get data >>>>>> " + value.error!);
//       } else {
//         print(value.token!);
//         //push
//       }
//     },
//   );
// }
  }
}
