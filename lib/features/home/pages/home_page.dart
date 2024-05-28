import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:manul/features/auth/pages/auth_gate.dart';
//import 'firebase_options.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myfield = TextEditingController();

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wyszukaj'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_sharp),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('services')
              .add({'title': myfield.text});
          myfield.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return Center(
            child: Text('1'),
          );
        }
        if (currentIndex == 1) {
          return Center(
            child: Text('2'),
          );
        }
        if (currentIndex == 2) {
          return Center(
            child: Text('3'),
          );
        }

        return StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('services').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Wystąpił nieoczekiwany problem');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Trwa ładowanie');
              }
              final services = snapshot.data!.docs;
              return ListView(
                children: [
                  for (final service in services) ...[
                    ListViewItem(service['title']),
                  ],
                  TextField(
                    controller: myfield,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              );
            });
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search_sharp), label: 'Wyszukaj'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_to_photos_sharp), label: 'Dodaj usługę'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_home_outlined), label: 'Dodaj firmę'),
        ],
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem(
    this.title, {
    super.key,
  });
  final String title;
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
        children: [Text(title)],
      ),
    );
  }
}
