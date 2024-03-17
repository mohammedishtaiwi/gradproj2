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

      final DateTime now = DateTime.now();
      final Timestamp timestamp = Timestamp.fromDate(now);

      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .update({
        'booked': true,
        'bookingTime': timestamp,
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
        final batch = FirebaseFirestore.instance.batch();
        snapshot.docs.forEach((doc) {
          batch.update(doc.reference, {'booked': false, 'bookingTime': null});
        });
        await batch.commit();
      } else {
        await FirebaseFirestore.instance
            .collection('Tickets')
            .doc(documentID)
            .update({
          'booked': false,
          'bookingTime': null,
        });
      }

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
