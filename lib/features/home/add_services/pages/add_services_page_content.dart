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
  var company = '';
  var prize = '';
  var maxprize = '';

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
        TextField(
          decoration: const InputDecoration(
            hintText: 'Podaj nazwę firmy',
          ),
          onChanged: (newValue) {
            setState(() {
              company = newValue;
            });
          },
          style: const TextStyle(color: Colors.white70),
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Podaj cenę',
          ),
          onChanged: (newValue) {
            setState(() {
              prize = newValue;
            });
          },
          style: const TextStyle(color: Colors.white70),
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Podaj cenę maksymalną',
          ),
          onChanged: (newValue) {
            setState(() {
              maxprize = newValue;
            });
          },
          style: const TextStyle(color: Colors.white70),
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('services').add({
              'service': service,
              'company': company,
              'prize': prize,
              'maxprize': maxprize,
            });
          },
          child: const Text('Dodaj'),
        )
      ],
    );
  }
}
