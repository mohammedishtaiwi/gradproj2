import 'package:gradproj2/apiwrapper.dart';
import 'package:gradproj2/bottomnavigationbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/forgetpasswordscreen.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

// ignore: camel_case_types
class _signinState extends State<signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool value = false;
  bool _isVisible = true;
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
      resizeToAvoidBottomInset: false,
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
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Welcome back!',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color:
                              Colors.black, // Adjust the text color as needed
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: _emailController,
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.blueGrey, // Same color as border
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
                        controller: _passwordController,
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.blueGrey, // Same color as border
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // ignore: avoid_unnecessary_containers

                      TextButton(
                        child: Text(
                          "Forgot Password?",
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
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Gilroy')),
                      backgroundColor: Color.fromARGB(255, 114, 151, 172),
                      onPressed: () async {
                        await _signInWithEmailAndPassword(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const BottomNav(),
          ),
        );
      } else if (user != null && !user.emailVerified) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email not verified'),
              content: const Text(
                  'Your email is not verified. Please check your email and verify your account before logging in.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print(
            'Failed to sign in: User not found or other authentication error.');
      }
    } catch (e) {
      print('Failed to sign in: $e');
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Error: Invalid username or password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
