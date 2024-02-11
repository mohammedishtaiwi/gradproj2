import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false to hide the debug banner
      title: 'Login App',
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


