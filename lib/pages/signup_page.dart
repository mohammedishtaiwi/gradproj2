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

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Navigate to the home page on successful sign up
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print('Failed to sign up: $e');
      // Handle sign up failure (show a snackbar, etc.)
    }
  }
}
