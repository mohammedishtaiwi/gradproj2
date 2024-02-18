import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/home_page_helpers.dart'; // Import the helper methods

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          buildPopupMenuButton(context, (value) {
            if (value == 'logout') {
              _signOut(context);
            }
          }),
        ],
      ),
      drawer: buildDrawer(context),
      body: Stack(
        children: [
          Column(
            children: [
              buildBlueSection(context),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Welcome to the Home Page!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildDividerBox(context),
        ],
      ),
    );
  }
}
