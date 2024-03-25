import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TicketDetailsPage extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  final String documentID;

  const TicketDetailsPage({
    Key? key,
    required this.ticketData,
    required this.documentID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any loading indicator
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        bool isTicketBooked = false;
if (snapshot.hasData) {
  Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;
  if (userData != null && userData.containsKey('bookedTickets')) {
    List<dynamic>? bookedTickets = userData['bookedTickets'];
    if (bookedTickets != null) {
      isTicketBooked = bookedTickets.contains(documentID);
    }
  }
}


        return Scaffold(
          appBar: AppBar(
            title: const Text('Ticket Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Flight Number: ${ticketData['flightNumber']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Departure: ${ticketData['departureCity']}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Arrival: ${ticketData['arrivalCity']}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Date: ${_formatFlightTime(ticketData['flightDate'])}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Price: ${ticketData['ticketPrice']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (!isTicketBooked)
                  ElevatedButton(
                    onPressed: () {
                      _bookTicket(context, ticketData, documentID);
                    },
                    child: const Text('Book'),
                  ),
                if (isTicketBooked)
                  ElevatedButton(
                    onPressed: () {
                      _undoBooking(context, documentID);
                    },
                    child: const Text('Undo Booking'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _bookTicket(BuildContext context,
      Map<String, dynamic> ticketData, String documentID) async {
    try {
      print('Booking document with $documentID');

      final DateTime now = DateTime.now();
      final Timestamp timestamp = Timestamp.fromDate(now);

      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .update({
        'booked': true,
        'bookingTime': timestamp,
      });

      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'bookedTickets': FieldValue.arrayUnion([documentID]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket booked successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error booking ticket: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to book the ticket. Please try again.'),
        ),
      );
    }
  }

  Future<void> _undoBooking(BuildContext context, String documentID) async {
    try {
      print('Undoing booking for document with $documentID');

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Tickets')
          .where('booked', isEqualTo: true)
          .get();

      if (snapshot.docs.length == 1) {
        // If only one ticket is booked, clear the array
        final currentUser = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update({
          'bookedTickets': FieldValue.delete(),
        });
      }
      // Otherwise, update the specific ticket document
      if (snapshot.docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();
        for (var doc in snapshot.docs) {
          batch.update(doc.reference, {
            'booked': false,
            'bookingTime': null,
          });
        }
        await batch.commit();
      }

      // Remove the undone ticket from the user's bookedTickets array
      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'bookedTickets': FieldValue.arrayRemove([documentID]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking undone successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error undoing booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to undo booking. Please try again.'),
        ),
      );
    }
  }

  String _formatFlightTime(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();

    String formattedTime = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedTime;
  }
}
