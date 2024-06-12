import 'package:flutter/material.dart';
import 'package:iba_app/Languages/languages.dart';
import 'package:iba_app/Screens/selected_screen.dart';
import 'package:iba_app/Screens/student_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const SelectedScreen(),
      routes: {
        '/student_login': (context) => StudentLoginScreen(),
        // Define other routes here if needed
      },
    );
  }
}
