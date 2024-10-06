import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manul/features/auth/pages/auth_gate.dart';
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
        textTheme:
            GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white70,
          displayColor:  const Color.fromARGB(255, 38, 174, 38), //???????
        ),
      ),
      home: const AuthGate(),
    );
  }
}
