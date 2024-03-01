import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Sign Up')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _signUp();
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to the login page when "Already have an account?" is pressed
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   Future<void> _signUp() async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: _usernameController.text,
//         password: _passwordController.text,
//       );

//       User? user = userCredential.user;
//       if (user != null) {
//         // Navigate to the home page on successful sign up
//         Navigator.pushReplacementNamed(context, '/home');
//       }
//     } catch (e) {
//       print('Failed to sign up: $e');
//       // Handle sign up failure (show a snackbar, etc.)
//     }
//   }
// }
  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Send email verification
        await user.sendEmailVerification();

        // Display a dialog to inform the user to check their email
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Verify your email'),
              content: Text(
                  'A verification email has been sent. Please check your email and verify your account.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Show CircularProgressIndicator while waiting for email verification
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
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
        await user.reload();
        user = _auth.currentUser;

        // Dismiss the CircularProgressIndicator dialog
        Navigator.of(context).pop();

        if (user != null && user.emailVerified) {
          // Navigate to the home page on successful sign up
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (e) {
      print('Failed to sign up: $e');
      // Handle sign up failure (show a snackbar, etc.)
    }
  }
}
