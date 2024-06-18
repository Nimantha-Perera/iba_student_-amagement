import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iba_app/Languages/languages.dart';
import 'package:iba_app/Screens/selected_screen.dart';
import 'package:iba_app/Staff_screens/portal.dart';
import 'package:iba_app/Staff_screens/staff_login.dart';
import 'package:iba_app/Stu_Screens/StudentData.dart';
import 'package:iba_app/Stu_Screens/portal.dart';
import 'package:iba_app/Stu_Screens/student_login.dart';
import 'package:iba_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LanguageManager.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool keepMeSignedIn = prefs.getBool('keepMeSignedIn') ?? false;
  String? index = prefs.getString('index');
  String? password = prefs.getString('password');

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(
        keepMeSignedIn: keepMeSignedIn,
        index: index,
        password: password,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool keepMeSignedIn;
  final String? index;
  final String? password;

  const MyApp({
    super.key,
    required this.keepMeSignedIn,
    this.index,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,    // Add the builder here
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: keepMeSignedIn ? AutoLoginScreen(index: index, password: password) : const SelectedScreen(),
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

class AutoLoginScreen extends StatefulWidget {
  final String? index;
  final String? password;

  const AutoLoginScreen({Key? key, this.index, this.password}) : super(key: key);

  @override
  _AutoLoginScreenState createState() => _AutoLoginScreenState();
}

class _AutoLoginScreenState extends State<AutoLoginScreen> {
  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    if (widget.index != null && widget.password != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('index', isEqualTo: widget.index)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userData = userSnapshot.docs.first.data();
        if (userData['password'] == widget.password) {
          Navigator.pushReplacementNamed(
              context, '/student_portal', arguments: StudentData(widget.index!, userData));
          return;
        }
      }
    }
    Navigator.pushReplacementNamed(context, '/student_login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
