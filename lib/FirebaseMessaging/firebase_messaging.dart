import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Cloudemassages extends StatefulWidget {
  const Cloudemassages({super.key});

  @override
  State<Cloudemassages> createState() => _CloudemassagesState();
}

class _CloudemassagesState extends State<Cloudemassages> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cloudemassages'),
      ),
    );
  }
}