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
  bool ispricebracket = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20,
      ),
      children: [
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Podaj nazwę usługi',
            label: Row(
              children: const [
                Text('Nazwa usługi'),
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              service = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Podaj nazwę firmy',
            label: Row(
              children: const [
                Text('Nazwa firmy'),
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              company = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'Przedział cenowy',
            ),
            Switch(
              value: ispricebracket,
              onChanged: (newValue) {
                setState(() {
                  ispricebracket = newValue;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'np.: 50',
                  label: Row(
                    children: [
                      Text(ispricebracket ? 'Cena min. w zł' : 'Cena w zł'),
                      const Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    prize = newValue;
                  });
                },
              ),
            ),
            Visibility(
              visible: ispricebracket,
              child: const Text('-'),
            ),
            Visibility(
              visible: ispricebracket,
              child: SizedBox(
                width: 150,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'np. 150',
                    label: Text('Cena max. w zł'),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      maxprize = newValue;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
            ),
            Expanded(
              child: Text(
                'Wymagane pola do odblokowania przycisku "DODAJ".',
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: service.isEmpty || company.isEmpty || prize.isEmpty
              ? null
              : () {
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
