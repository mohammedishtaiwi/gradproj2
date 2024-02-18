import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookedTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Booked Tickets')),
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

            List<Map<String, dynamic>> bookedTickets = snapshot.data!.docs
                .map((DocumentSnapshot document) => document.data() as Map<String, dynamic>)
                .where((ticket) => ticket['booked'] ?? false)
                .toList();

            return ListView(
              children: bookedTickets.map((data) {
                return GestureDetector(
                  onTap: () {
                    // Handle onTap for booked ticket details if needed
                  },
                  child: Card(
                    //... (rest of the card styling)
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
