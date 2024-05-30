import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manul/features/home/add_company/pages/add_company_page_content.dart';
import 'package:manul/features/home/add_services/pages/add_services_page_content.dart';
import 'package:manul/features/home/search/pages/search_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (currentIndex == 1) {
            return const Text('Dodaj usługę');
          }
          if (currentIndex == 2) {
            return const Text('Dodaj firmę');
          }
          return const Text('Wyszukaj');
        }),
        actions: [
          Builder(builder: (context) {
            if (currentIndex == 0) {
              return IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_outlined),
              );
            }
            return IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout_sharp),
            );
          })
        ],
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const SearchPageContent();
        }
        if (currentIndex == 1) {
          return AddServicesPageContent();
        }

        return const AddCompanyPageContent();
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
