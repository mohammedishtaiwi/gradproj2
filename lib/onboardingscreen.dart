import 'package:flutter/material.dart';
import 'package:gradproj2/homepage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class onboarding extends StatefulWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  State<onboarding> createState() => _onboardingState();
}

// ignore: camel_case_types
class _onboardingState extends State<onboarding> {
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
      body: Padding(
        padding: const EdgeInsets.only(top: 74),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Image.asset('assets/onboardingscreen02.png'),
              ),
              const SizedBox(height: 67),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Discover",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Amazing Places",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
              const SizedBox(height: 11),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Adventure new places.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 44),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: FloatingActionButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    // ignore: sort_child_properties_last
                    child: const Text('GET STARTED',
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Gilroy')),
                    backgroundColor: Colors.blueAccent.shade400,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const home()),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
