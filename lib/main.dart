import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wyszukaj'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('services').snapshots(),
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
                  ListViewItem(documents[0]['title']),
                  ListViewItem('Układanie fryzury'),
                ],
              );
            }),
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
      child: Row(
        children: [Text(title)],
      ),
    );
  }
}
