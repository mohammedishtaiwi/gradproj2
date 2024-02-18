import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/signup_page.dart';
import 'pages/tickets.dart'; // Import the new Tickets page file

class Routes {
  static const String login = '/';
  static const String home = '/home';
  static const String signup = '/signup';
  static const String tickets = '/tickets'; // Define the route for Tickets page

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case tickets:
        return MaterialPageRoute(builder: (_) => TicketsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
