// // ignore: camel_case_types
// class _signupState extends State<signup> {
//   // TextEditingController email = TextEditingController();
//   // TextEditingController password = TextEditingController();
//   // TextEditingController fullname = TextEditingController();
//   bool _isVisible = false;
//   final TextEditingController fullname = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   PickedFile? _pickedImage;

//   @override
//   void initState() {
//     userlogin();
//     super.initState();
//   }

//   final _formKey = GlobalKey<FormState>();
//   late ColorNotifire notifire;
//   getdarkmodepreviousstate() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? previusstate = prefs.getBool("setIsDark");
//     if (previusstate == null) {
//       notifire.setIsDark = false;
//     } else {
//       notifire.setIsDark = previusstate;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Scaffold(
//       backgroundColor: notifire.backgroundallscreenColor,
//       //resizeToAvoidBottomInset: false,
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   height: 18,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     text: 'Hello,',
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: notifire.getdarkscolor,
//                         fontFamily: 'Gilroy'),
//                     children: <TextSpan>[
//                       // TextSpan(
//                       //     text: 'There',
//                       //     style: TextStyle(
//                       //         fontWeight: FontWeight.bold,
//                       //         fontSize: 30,
//                       //         color: notifire.getdarkscolor,
//                       //         fontFamily: 'Gilroy')),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "Enter your information below to get\nstarted on your trips",
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: notifire.greytextColor,
//                       fontFamily: 'Gilroy'),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 Column(
//                   children: [
//                     TextFormField(
//                       controller: fullname,
//                       textInputAction: TextInputAction.next,
//                       style: TextStyle(
//                           color: notifire.getdarkscolor, fontFamily: "gilroy"),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your Name';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(
//                             color: notifire.getdarkscolor,
//                             fontFamily: "gilroy"),
//                         fillColor: Colors.white,
//                         hintText: 'Enter Your full name',
//                         labelText: "FULL NAME",
//                         labelStyle: TextStyle(
//                             color: notifire.getdarkscolor,
//                             fontFamily: "gilroy"),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             color: notifire.getgreycolor,
//                           ),
//                         ),
//                         // decoration: InputDecoration(
//                         //   hintText: 'percy jackson',
//                         //   labelText: "FULL NAME",
//                         //   border: OutlineInputBorder(
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     borderSide: const BorderSide(
//                         //       color: Colors.red,
//                         //       width: 5.0,
//                         //     ),
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     TextFormField(
//                       controller: email,
//                       style: TextStyle(
//                           color: notifire.getdarkscolor, fontFamily: "gilroy"),
//                       keyboardType: TextInputType.emailAddress,
//                       textInputAction: TextInputAction.next,
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(
//                             color: notifire.getdarkscolor,
//                             fontFamily: "gilroy"),
//                         fillColor: Colors.white,
//                         hintText: 'Enter Your Email',
//                         labelText: "EMAIL",
//                         labelStyle: TextStyle(
//                             color: notifire.getdarkscolor,
//                             fontFamily: "gilroy"),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             color: notifire.getgreycolor,
//                           ),
//                         ),
//                         // decoration: InputDecoration(
//                         //   hintText: 'percy jackson',
//                         //   labelText: "FULL NAME",
//                         //   border: OutlineInputBorder(
//                         //     borderRadius: BorderRadius.circular(10),
//                         //     borderSide: const BorderSide(
//                         //       color: Colors.red,
//                         //       width: 5.0,
//                         //     ),
//                         //   ),
//                         // ),
//                       ),
//                       // decoration: InputDecoration(
//                       //   hintText: 'i.e,percyjackson@gmail.com',
//                       //   labelText: "EMAIL",
//                       //   border: OutlineInputBorder(
//                       //     borderRadius: BorderRadius.circular(10),
//                       //     borderSide: const BorderSide(
//                       //       color: Colors.red,
//                       //       width: 5.0,
//                       //     ),
//                       //   ),
//                       // ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     TextFormField(
//                       controller: password,
//                       obscureText: _isVisible,
//                       textInputAction: TextInputAction.next,
//                       style: TextStyle(
//                           color: notifire.getdarkscolor, fontFamily: "gilroy"),
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _isVisible = !_isVisible;
//                             });
//                           },
//                           icon: _isVisible
//                               ? const Icon(
//                                   Icons.visibility_off_outlined,
//                                   color: Colors.grey,
//                                 )
//                               : const Icon(
//                                   Icons.visibility_outlined,
//                                   color: Colors.grey,
//                                 ),
//                         ),
//                         hintText: "Enter Your Password",
//                         hintStyle: TextStyle(
//                             color: notifire.getdarkscolor,
//                             fontFamily: "gilroy"),
//                         labelText: "PASSWORD",
//                         labelStyle: TextStyle(
//                             color: notifire.getdarkscolor,
//                             fontFamily: "gilroy"),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             color: notifire.getgreycolor,
//                           ),
//                         ),
//                         // hintText: 'Enter Your Password',
//                         // labelText: "PASSWORD",
//                         // border: OutlineInputBorder(
//                         //   borderRadius: BorderRadius.circular(10),
//                         //   borderSide: const BorderSide(
//                         //     color: Colors.red,
//                         //     width: 5.0,
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 // ignore: avoid_unnecessary_containers
//                 Container(
//                   child: FloatingActionButton(
//                       elevation: 0,
//                       heroTag: 'Sign-up',
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                       child: const Text('SIGN UP',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 18,
//                               fontFamily: 'Gilroy')),
//                       backgroundColor: Colors.blueAccent.shade400,
//                       autofocus: true,
//                       onPressed: () {
//                         Navigator.pushReplacementNamed(context, '/');
//                       }
//                       // () async {
//                       //   var body = {
//                       //     "name": fullname.text,
//                       //     "email": email.text,
//                       //     "password": password.text,
//                       //     "mobile": "7041494098",
//                       //     "ccode": "+91",
//                       //     "refercode": ""
//                       //   };
//                       //   apiwrapper.datapost(body);
//                       // },
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//    Future<void> _signUp() async {
//     try {
//       if (password.text.length < 6) {
//         _showErrorDialog("Password must be at least 6 characters long.");
//         return;
//       }

//       // Check if a profile picture is uploaded
//       if (_pickedImage == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please upload a photo'),
//           ),
//         );
//         return;
//       }

//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email.text,
//         password: password.text,
//       );

//         // Save user data to Firestore
//         await _firestore.collection('users').doc(user.uid).set({
//           'username': fullname.text,
//           'password': password.text,
//           'name': email.text,
//         });

//         await user.sendEmailVerification();

//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Verify your email'),
//               content: const Text(
//                 'A verification email has been sent. Please check your email and verify your account.',
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/');
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );

//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return const AlertDialog(
//               content: Row(
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(width: 20),
//                   Text('Verifying email...'),
//                 ],
//               ),
//             );
//           },
//         );

//         // Wait for the user to verify their email before navigating to home
//         await user.reload();
//         user = _auth.currentUser;

//         // Dismiss the CircularProgressIndicator dialog
//         Navigator.of(context).pop();

//         if (user != null && user.emailVerified) {
//           // Navigate to the home page on successful sign up
//           Navigator.pushReplacementNamed(context, '/home');
//         }
//       }
//     } catch (e) {
//       print('Failed to sign up: $e');
//       // Handle sign up failure (show a snackbar, etc.)
//       _showErrorDialog("Failed to sign up. Please try again.");
//     }
//   }

//   void _showErrorDialog(String errorMessage) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(errorMessage),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gradproj2/apiwrapper.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _SignupState();
}

class _SignupState extends State<signup> {
  bool _isVisible = false;
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  PickedFile? _pickedImage;

  @override
  void initState() {
    getDarkModePreviousState();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  Future<void> getDarkModePreviousState() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previousState = prefs.getBool("setIsDark");
    if (previousState == null) {
      // Handle if the previous state is null
    } else {
      // Handle if the previous state is not null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust the background color as needed
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        color: Colors.black, // Adjust the text color as needed
                        fontFamily: 'Gilroy'),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'There',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors
                                  .black, // Adjust the text color as needed
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
                      color: Colors.grey, // Adjust the text color as needed
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "FULL NAME",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Adjust the border color as needed
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "EMAIL",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Adjust the border color as needed
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: !_isVisible,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: Icon(
                            _isVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: "PASSWORD",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors
                                .grey, // Adjust the border color as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                FloatingActionButton(
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
                  onPressed: () {
                    _signUp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    try {
      if (password.text.length < 6) {
        _showErrorDialog("Password must be at least 6 characters long.");
        return;
      }

      // // Check if a profile picture is uploaded
      // if (_pickedImage == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Please upload a photo'),
      //     ),
      //   );
      //   return;
      // }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': fullname.text,
        'password': password.text,
        'name': email.text,
      });

      await userCredential.user!.sendEmailVerification();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Verify your email'),
            content: const Text(
              'A verification email has been sent. Please check your email and verify your account.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Verifying email...'),
              ],
            ),
          );
        },
      );

      // Wait for the user to verify their email before navigating to home
      await userCredential.user!.reload();
      User? user = _auth.currentUser;
      // Dismiss the CircularProgressIndicator dialog
      Navigator.of(context).pop();

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        // Navigate to the home page on successful sign up
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print('Failed to sign up: $e');
      // Handle sign up failure (show a snackbar, etc.)
      _showErrorDialog("Failed to sign up. Please try again.");
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
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
  }
}
