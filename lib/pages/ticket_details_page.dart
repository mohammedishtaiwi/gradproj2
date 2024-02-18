import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketDetailsPage extends StatelessWidget {
  final Map<String, dynamic> ticketData;
    final String documentID;
      final bool isBooked;



  const TicketDetailsPage({Key? key, required this.ticketData,required this.documentID,required this.isBooked}) : super(key: key);

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

            // Booking and Cancel buttons
            ElevatedButton(
              onPressed: () {
                _bookTicket(context, ticketData,documentID);
              },
              child: const Text('Book'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle canceling ticket
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _bookTicket(BuildContext context, Map<String, dynamic> ticketData, String documentID) async {
  try {
    // Implement the logic for booking the ticket
    // For example, update the Firestore database to mark the ticket as booked for the specific user

    // Assuming you have a 'booked' field in Firestore for each ticket
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(documentID) // Use the provided document ID
        .update({'booked': true});

    // Once booked, you may want to navigate back to the TicketsPage or show a success message
    Navigator.pop(context); // Navigate back to TicketsPage
  } catch (e) {
    // Handle any errors that occur during booking
    print('Error booking ticket: $e');
  }
}

}
