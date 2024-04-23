import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  PickedFile? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Sign Up')),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
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
                    await _pickImage();
                  },
                  child: const Text('Pick Profile Picture'),
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
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text('Already have an account? Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedFile != null ? PickedFile(pickedFile.path) : null;
    });
  }

  Future<String?> _uploadImage() async {
    if (_pickedImage == null) return null;

    try {
      final Reference storageReference = _storage
          .ref()
          .child('profile_images/${DateTime.now().toIso8601String()}');
      final UploadTask uploadTask =
          storageReference.putFile(File(_pickedImage!.path));
      await uploadTask.whenComplete(() => null);

      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> _signUp() async {
    try {
      if (_passwordController.text.length < 6) {
        _showErrorDialog("Password must be at least 6 characters long.");
        return;
      }

      // Check if a profile picture is uploaded
      if (_pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload a photo'),
          ),
        );
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Upload image and get download URL
        final imageUrl = await _uploadImage();

        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'username': _usernameController.text,
          'password': _passwordController.text,
          'name': _nameController.text,
          'profileImageUrl': imageUrl,
        });

        await user.sendEmailVerification();

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
