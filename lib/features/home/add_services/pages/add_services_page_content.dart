import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddServicesPageContent extends StatelessWidget {
  AddServicesPageContent({
    super.key,
  });
  final myfield = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Wystąpił nieoczekiwany problem');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Trwa ładowanie');
          }
          return ListView(
            children: [
              TextField(
                controller: myfield,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          );
        });
    //       floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     FirebaseFirestore.instance
    //         .collection('services')
    //         .add({'title': myfield.text});
    //     myfield.clear();
    //   },
    //   child: const Icon(Icons.add),
    // ),
  }
}

