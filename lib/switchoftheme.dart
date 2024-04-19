// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///switch variable======
bool status = false;

class themeswitch extends StatefulWidget {
  const themeswitch({Key? key}) : super(key: key);

  @override
  State<themeswitch> createState() => _themeswitchState();
}

class _themeswitchState extends State<themeswitch> {
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
      backgroundColor: notifire.getprimerycolor,
      body: Center(
        child: Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            value: status,
            activeColor: notifire.getbluecolor,
            onChanged: (bool value) async {
              setState(() {
                status = value;
              });
              final prefs = await SharedPreferences.getInstance();
              setState(
                () {
                  notifire.setIsDark = value;
                  prefs.setBool("setIsDark", value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
