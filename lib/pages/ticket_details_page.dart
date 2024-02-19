import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketDetailsPage extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  final String documentID;
  final bool isBooked;

  const TicketDetailsPage({
    Key? key,
    required this.ticketData,
    required this.documentID,
    required this.isBooked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display ticket details using ticketData
            Text(
              'Flight Number: ${ticketData['flightNumber']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              'Date: ${ticketData['flightTime']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Price: ${ticketData['ticketPrice']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Add more details as needed based on your Firestore schema

            // Booking button conditionally shown
            if (!isBooked)
              ElevatedButton(
                onPressed: () {
                  _bookTicket(context, ticketData, documentID);
                },
                child: const Text('Book'),
              ),
               if (isBooked)
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
  }

Future<void> _bookTicket(BuildContext context,
      Map<String, dynamic> ticketData, String documentID) async {
    try {
      print('Booking document with $documentID');

      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .update({'booked': true});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ticket booked successfully!'),
        ),
      );

      // Optionally, navigate to a new screen or pop the current screen
      Navigator.pop(context);
    } catch (e) {
      // Handle any errors that occur during booking
      print('Error booking ticket: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to book the ticket. Please try again.'),
        ),
      );
    }
  }
  Future<void> _undoBooking(BuildContext context, String documentID) async {
    try {
      print('Undoing booking for document with $documentID');

      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .update({'booked': false});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Booking undone successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      // Handle any errors that occur during undoing booking
      print('Error undoing booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to undo booking. Please try again.'),
        ),
      );
    }
  }


}
