import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('services')
            .orderBy('prize')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Wystąpił nieoczekiwany problem');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Trwa ładowanie');
          }
          final documents = snapshot.data!.docs;
          return ListView(
            children: [
              for (final document in documents) ...[
                ListViewItem(
                  document['service'],
                  document['company'],
                  document['prize'],
                ),
              ],
            ],
          );
        });
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem(
    this.service,
    this.company,
    this.prize, {
    super.key,
  });
  final String service;
  final String company;
  final String prize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: const Color.fromARGB(255, 245, 245, 245),
      padding: const EdgeInsets.only(
        right: 20,
      ),
      margin: const EdgeInsets.only(
        top: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service),
              Text(company),
            ],
          ),
          Row(
            children: [
              Text(prize),
              const Text('zł'),
            ],
          )
        ],
      ),
    );
  }
}
