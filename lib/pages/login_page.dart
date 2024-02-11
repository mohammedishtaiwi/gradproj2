import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Center(child: Text('Login Page')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
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
                  await _signInWithEmailAndPassword();
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  _checkUserExistsThenNavigate();
                },
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Handle successful login (e.g., navigate to home page)
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Failed to sign in: $e');
      // Handle login failure (show a snackbar, etc.)
    }
  }

  Future<void> _checkUserExistsThenNavigate() async {
    try {
      // Check if the user exists in Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // User exists, navigate to the home page
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // User doesn't exist, prompt them to sign up
        Navigator.pushReplacementNamed(context, '/signup');
      }
    } catch (e) {
      // Handle potential errors (user doesn't exist, Firebase error, etc.)
      print('Failed to check user existence: $e');
      // Prompt the user to sign up
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }
}
