import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
enum SingingCharacter { Economy, Business, Premium }

// ignore: camel_case_types
class roundtripcabinclass extends StatefulWidget {
  const roundtripcabinclass({Key? key}) : super(key: key);

  @override
  State<roundtripcabinclass> createState() => _roundtripcabinclassState();
}

// ignore: camel_case_types
class _roundtripcabinclassState extends State<roundtripcabinclass> {
  SingingCharacter? _character = SingingCharacter.Economy;
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
      backgroundColor: notifire.notificationbackground,
      body: Center(
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              color: notifire.splashscreenprimeryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Center(
                child: Theme(
                  data: ThemeData(
                    unselectedWidgetColor: notifire.greytextColor,
                  ),
                  child: RadioListTile<SingingCharacter>(
                    title: Text(
                      'Economy',
                      style: TextStyle(
                          fontFamily: "gilroy",
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    value: SingingCharacter.Economy,
                    toggleable: true,
                    controlAffinity: ListTileControlAffinity.trailing,
                    groupValue: _character,
                    dense: false,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: notifire.notificationbackground),
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: notifire.greytextColor),
                child: RadioListTile<SingingCharacter>(
                  title: Text(
                    'Business',
                    style: TextStyle(
                        fontFamily: "gilroy",
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  value: SingingCharacter.Business,
                  // activeColor: Colors.grey,

                  controlAffinity: ListTileControlAffinity.trailing,
                  //tileColor:notifire.splashscreenprimeryColor,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: notifire.notificationbackground),
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: notifire.greytextColor),
                child: RadioListTile<SingingCharacter>(
                  dense: true,
                  title: Text(
                    'Premium',
                    style: TextStyle(
                        fontFamily: "gilroy",
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  value: SingingCharacter.Premium,
                  controlAffinity: ListTileControlAffinity.trailing,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(
                      () {
                        _character = value;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
