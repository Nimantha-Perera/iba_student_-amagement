import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iba_app/Languages/languages.dart';
import 'package:iba_app/Screens/selected_screen.dart';
import 'package:iba_app/Staff_screens/portal.dart';
import 'package:iba_app/Staff_screens/staff_login.dart';
import 'package:iba_app/Stu_Screens/portal.dart';
import 'package:iba_app/Stu_Screens/student_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageManager.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,    // Add the builder here
      useInheritedMediaQuery: true,  
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const SelectedScreen(),
      routes: {
        '/student_login': (context) => StudentLoginScreen(),
        '/staff_login': (context) => StaffLoginScreen(),
        '/staff_portal': (context) => StaffPortalScreen(),
        '/student_portal': (context) => StudentPortalScreen(),
        // Define other routes here if needed
      },
    );
  }
}
