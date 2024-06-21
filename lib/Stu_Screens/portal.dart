import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iba_app/Languages/languages.dart';
import 'package:iba_app/Notifications%20Service/notifcation_service.dart';
import 'package:iba_app/Side%20Nav%20Bar/side_nav_stu.dart';
import 'package:iba_app/Stu_Screens/StudentData.dart';
import 'package:iba_app/Stu_Screens/notification_btn.dart';

class StudentPortalScreen extends StatefulWidget {
  const StudentPortalScreen({Key? key}) : super(key: key);

  @override
  State<StudentPortalScreen> createState() => _StudentPortalScreenState();
}


String _getText(String key) {
  return LanguageManager.getText(key); // Utilize the LanguageManager to get translated text
}

final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

class _StudentPortalScreenState extends State<StudentPortalScreen> {
  NotificationService notificationService = NotificationService();
  @override

  void initState() {
    super.initState();
    notificationService.initialize();

    notificationService.getFcmToken().then((value) {
      print("Token: $value");
    });
    notificationService.onTokenRefresh();
  }
  Widget build(BuildContext context) {
    final StudentData args = ModalRoute.of(context)!.settings.arguments as StudentData;
    String batch = args.userData['batch'];

    return Scaffold(
      key: _scaffoldKey2,
      drawer: SideNavStu(),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(30.0), // Set the desired border radius here
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.call),
          backgroundColor: const Color.fromARGB(255, 61, 61, 61),
          foregroundColor: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _getText("Student Portal"),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey2.currentState?.openDrawer();
          },
        ),
        actions: [NotificationIconButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                        ),
                        title: Text(
                          'Welcome ${args.userData['l_name']}',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700]),
                        ),
                        subtitle: Text(
                          '${args.userData['batch']} | ${args.userData['course']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  )),
                              SizedBox(width: 10),
                              Text(
                                _getText("Notification"),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('notifications')
                                      .doc(batch)
                                      .collection('messages')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'Notifications is empty',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                    var notifications = snapshot.data!.docs
                                        .map((doc) => doc.data() as Map<String, dynamic>)
                                        .toList();
                                    return ListView.builder(
                                      itemCount: notifications.length,
                                      itemBuilder: (context, index) {
                                        final message = notifications[index]['message'];
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "• ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                message != null
                                                    ? message
                                                    : 'No message available',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  )),
                              SizedBox(width: 10),
                              Text(
                                _getText("Menu"),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 212, 212, 212)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(100, 70)),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.list,
                                        size: 36,
                                        color: const Color.fromARGB(255, 83, 83, 83),
                                      ),
                                    ),
                                    Text(_getText('Results')),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 212, 212, 212)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(100, 70)),
                                      ),
                                      child: Icon(
                                        Icons.payment,
                                        size: 40,
                                        color: const Color.fromARGB(255, 83, 83, 83),
                                      ),
                                    ),
                                    Text(_getText('Payment')),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 212, 212, 212)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(100, 70)),
                                      ),
                                      child: Icon(
                                        Icons.book,
                                        size: 40,
                                        color: Color.fromARGB(255, 83, 83, 83),
                                      ),
                                    ),
                                    Text(_getText('Tutes')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 212, 212, 212)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(100, 70)),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.video,
                                        size: 36,
                                        color: const Color.fromARGB(255, 83, 83, 83),
                                      ),
                                    ),
                                    Text(_getText('Videos')),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 212, 212, 212)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(100, 70)),
                                      ),
                                      child: Icon(
                                        Icons.assignment,
                                        size: 40,
                                        color: const Color.fromARGB(255, 83, 83, 83),
                                      ),
                                    ),
                                    Text(_getText('Online Exams')),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Add your onPressed logic here
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 212, 212, 212)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(100, 70)),
                                      ),
                                      child: Icon(
                                        Icons.video_camera_front_rounded,
                                        size: 40,
                                        color: Color.fromARGB(255, 83, 83, 83),
                                      ),
                                    ),
                                    Text(_getText('Live Lectures')),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
