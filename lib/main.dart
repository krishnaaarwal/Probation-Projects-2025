import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/MoreScreens/splash_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Royale',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[800]!,
      ),

      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const Thinkcell(),
    );
  }
}
