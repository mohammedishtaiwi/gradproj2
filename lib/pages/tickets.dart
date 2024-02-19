import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ticket_details_page.dart'; // Import the TicketDetailsPage

class TicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tickets')),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Tickets').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                    bool isBooked = data['booked'] ?? false;

                    if (!isBooked) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TicketDetailsPage(
                                ticketData: data,
                                documentID: document.id,
                                isBooked: isBooked,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: const Color.fromARGB(255, 48, 48, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Flight Number: ${data['flightNumber']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text(' ${data['ticketPrice']}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text('Departure: ${data['departureCity']}',
                                    style: const TextStyle(color: Colors.white)),
                                Text('Arrival: ${data['arrivalCity']}',
                                    style: const TextStyle(color: Colors.white)),
                                Text('Date: ${data['flightTime']}',
                                    style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Return an empty container for booked tickets
                      return Container();
                    }
                  })
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
