import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddServicesPageContent extends StatefulWidget {
  const AddServicesPageContent({
    super.key,
  });

  @override
  State<AddServicesPageContent> createState() => _AddServicesPageContentState();
}

class _AddServicesPageContentState extends State<AddServicesPageContent> {
  var service = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Podaj nazwę usługi',
          ),
          onChanged: (newValue) {
            setState(() {
              service = newValue;
            });
          },
          style: const TextStyle(color: Colors.white70),
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('services').add({
              'title': service,
            });
          },
          child: const Text('Dodaj'),
        )
      ],
    );
  }
}
