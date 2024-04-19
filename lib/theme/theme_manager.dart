
import 'package:flutter/material.dart';

import 'colors.dart';

class ColorNotifire with ChangeNotifier {
  bool _isDark = false;
  set setIsDark(value) {
    _isDark = value;
    notifyListeners();
  }
  get splashscreenprimeryColor => _isDark? splashscreendarkPrimeryColor : splashlightscreenprimeryColor;
  get addbagsdecoration => _isDark? addbagsdarkColor :addbagslightColor;
  get mapofboardingpass => _isDark? boardingpassmapdarkColor :boardingpassmaplightColor;
  get selectseats => _isDark?  seatsdarkColor: seatslightColor;
  get selectseats2 => _isDark?  seatsdarkColor2: seatslightColor2;
  get backgroundallscreenColor => _isDark? allscreendarkColor : allscreenlightColor;
  get profileColor => _isDark? profiledarkColor  : profilelightColor;
  get ticketdecorationcolor => _isDark?  ticketdecorationdarkColor  : ticketdecorationlightColor;
  get ticketdecorationcolor2 => _isDark?  ticketdecorationdarkColor2  : ticketdecorationlightColor2;
  get filterandshortmainColor => _isDark? filterdarkColor  : filtericonlightColor;
  get bottomnavigationbarbacground => _isDark? backgroundnavigationdarkColor : backgrondnavigationlightColor;
  get homepagebookingsectionmain => _isDark? backgroundhomepage1darkColor : backgroundhomepage1lightColor;
  get notificationbackground => _isDark? backgrounddarkColor : backgroundlightColor;
  get notificationbackground1 => _isDark? background1darkColor : background1lightColor;
  get backbuttonborderColor => _isDark? backbuttonborderdarkColor : backbutttonborderlightColor;
  get backbuttoniconColor => _isDark? icondarkColor : iconlightColor;
  get greytextColor => _isDark? greytextdarkColor  : greytextlightColor ;
  get apple => _isDark? applescreendarkPrimeryColor : applelightscreenprimeryColor;
  get loginbutton => _isDark? signinupscreendarkPrimeryColor : signinupscreendarkPrimeryColor;
  get getprimerycolor => _isDark ? darkPrimeryColor : primeryColor;
  get getdarkscolor => _isDark ? lightColor : darkColor;
  get getgreycolor => _isDark ? lightgreyColor : darkgreyColor;
  get getbluecolor => _isDark ? darkblueColor : lightblueColor;
  get getbox => _isDark ? darkbox : lightbox;
  get greyfont => _isDark ? greydark : greylight;
  get station => _isDark ? stationdark : stationlight;
  get bar => _isDark ? serchbaard : serchbaarl;
  get black => _isDark ? b : l;
  get bg => _isDark ? darkPrimeryColor : bgcolor;
  get detail => _isDark ? a : d;
}