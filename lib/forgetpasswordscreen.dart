import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  late ColorNotifire notifire;
  TextEditingController emailController = TextEditingController();

  // Method to send password reset email
// Method to send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Check if email exists in Firebase users
      var user = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (user.isNotEmpty) {
        // Email exists, send password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Show success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password reset email has been sent to your inbox."),
          ),
        );
      } else {
        // Email does not exist in Firebase users
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email not found. Please enter a valid email."),
          ),
        );
      }
    } catch (error) {
      // Error occurred while sending email or checking email existence
      print("Failed to send password reset email: $error");
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send password reset email."),
        ),
      );
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
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: notifire.backbuttoniconColor,
                    ),
                    iconSize: 14,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
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
            SizedBox(height: 50),
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
                SizedBox(width: 10),
                Text(
                  'password?',
                  style: TextStyle(
                      fontSize: 32,
                      color: notifire.getdarkscolor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy'),
                ),
              ],
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 55),
            TextField(
              controller: emailController,
              style:
                  TextStyle(color: notifire.getgreycolor, fontFamily: "gilroy"),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: notifire.getdarkscolor, fontFamily: "gilroy"),
                fillColor: Colors.black,
                hintText: 'Enter Your Email',
                labelText: "EMAIL",
                labelStyle:
                    TextStyle(color: notifire.black, fontFamily: "gilroy"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: notifire.getgreycolor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: FloatingActionButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Text(
                  'SEND CODE',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      color: Colors.black),
                ),
                backgroundColor: Color.fromARGB(255, 114, 151, 172),
                onPressed: () {
                  String enteredEmail = emailController.text.trim();
                  // Check if email is not empty
                  if (enteredEmail.isNotEmpty) {
                    // Check if email exists in Firebase
                    sendPasswordResetEmail(enteredEmail);
                  } else {
                    // Show error message if email field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter your email."),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
