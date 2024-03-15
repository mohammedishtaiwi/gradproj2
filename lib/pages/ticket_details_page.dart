import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
              'Date: ${_formatFlightTime(ticketData['flightDate'])}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Price: ${ticketData['ticketPrice']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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

      // Get the current timestamp
      final DateTime now = DateTime.now();
      final Timestamp timestamp = Timestamp.fromDate(now);

      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .update({
        'booked': true,
        'bookingTime': timestamp, // Update the bookingTime field
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

      // Check if the ticket is already booked
      final DocumentSnapshot ticketSnapshot = await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .get();

      if (ticketSnapshot.exists) {
        final bool isBooked = ticketData['booked'] ?? false;

        if (isBooked) {
          await FirebaseFirestore.instance
              .collection('Tickets')
              .doc(documentID)
              .update({
            'booked': false,
            'bookingTime': null, // Set bookingTime to null
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Booking undone successfully!'),
            ),
          );

          Navigator.pop(context);
        } else {
          // Ticket is not booked, show appropriate message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ticket is not booked.'),
            ),
          );
        }
      } else {
        // Document not found, handle as needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ticket document not found.'),
          ),
        );
      }
    } catch (e) {
      print('Error undoing booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to undo booking. Please try again.'),
        ),
      );
    }
  }
}

String _formatFlightTime(Timestamp flightTime) {
  // Convert Timestamp to DateTime
  DateTime dateTime = flightTime.toDate();

  // Format the DateTime to a human-readable string
  String formattedTime = DateFormat('yyyy-MM-dd').format(dateTime);

  return formattedTime;
}
