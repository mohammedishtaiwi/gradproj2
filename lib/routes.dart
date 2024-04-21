import 'package:flutter/material.dart';
import 'package:gradproj2/homepage1.dart';

import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/Chat_bot_page.dart';
import 'package:gradproj2/pages/edit_profile.dart';
import 'package:gradproj2/pages/profile_page.dart';
import 'package:gradproj2/pages/ticket_details_page.dart';
// import 'package:gradproj2/pages/profile_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/tickets.dart'; // Import the new Tickets page file

class Routes {
  static const String login = '/';
  static const String home = '/home';
  static const String signup = '/signup';
  static const String tickets = '/tickets';
  static const String bookedTickets = '/booked';
  static const String profile = '/profile';
  static const String chat = '/chat';

  static const String editProfile = '/edit';
  static const String ticketsDetailsPage = '/ticketsDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const home1());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case tickets:
        return MaterialPageRoute(builder: (_) => const TicketsPage());
      case bookedTickets:
        return MaterialPageRoute(builder: (_) => const BookedTicketsPage());
      case chat:
        return MaterialPageRoute(builder: (_) => const Chat());
      case profile:
        return MaterialPageRoute(builder: (_) => const Profile());

      case ticketsDetailsPage:
        return MaterialPageRoute(
            builder: (_) => const TicketDetailsPage(
                  ticketData: {},
                  documentID: '',
                ));
      case editProfile:
        return MaterialPageRoute(
            builder: (_) => const EditProfilePage(
                  profileImageUrl: '',
                  currentName: '',
                  currentUsername: '',
                ));

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
