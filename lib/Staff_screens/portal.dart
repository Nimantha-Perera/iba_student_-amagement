import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iba_app/Languages/languages.dart';
import 'package:iba_app/Side%20Nav%20Bar/side_navigation.dart';
import 'package:iba_app/Stu_Screens/notification_btn.dart';
import 'package:iba_app/StudentList/stu_list.dart';

class StaffPortalScreen extends StatefulWidget {
  const StaffPortalScreen({super.key});

  @override
  State<StaffPortalScreen> createState() => _StaffPortalScreenState();
}

String _getText(String key) {
  return LanguageManager.getText(
      key); // Utilize the LanguageManager to get translated text
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

List<String> _courses = ['BICT', 'BBA', 'DICT'];
String? _selectedValue;
String _selectedBatch = 'Select Batch'; // Initial selected batch

final List<String> _dropdownItems = [
  'Select Batch',
  'Batch 1000 ',
  'Batch 1001',
  'Batch 1002',
  'Batch 1003',
  'Batch 1004',
];

class _StaffPortalScreenState extends State<StaffPortalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: ClipRRect(
        borderRadius:
            BorderRadius.circular(30.0), // Set the desired border radius here
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.question_mark_sharp),
          backgroundColor: const Color.fromARGB(255, 61, 61, 61),
          foregroundColor: Colors.white,
        ),
      ),
      drawer: MyDrawer(),
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
            _scaffoldKey.currentState?.openDrawer();
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
                          'Welcome Samarasinghe',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700]),
                        ),
                        subtitle: Text(
                          'IBA Staff',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (modalContext) =>
                                                Container(
                                              height: 300,
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Batch List",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount:
                                                          _dropdownItems.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                          title: Text(
                                                            _dropdownItems[
                                                                index],
                                                          ),
                                                          onTap: () {
                                                            // Navigate to StudentList screen with selected batch name
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        StudentList(
                                                                  batchName:
                                                                      _dropdownItems[
                                                                          index],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 212, 212, 212)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(100, 70)),
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.list,
                                          size: 36,
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
                                        ),
                                      ),
                                      Text(_getText('Student List')),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 212, 212, 212)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(100, 70)),
                                        ),
                                        child: Icon(
                                          Icons.payment,
                                          size: 40,
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
                                        ),
                                      ),
                                      Text(_getText('Payment Hadle')),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 212, 212, 212)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(100, 70)),
                                        ),
                                        child: Icon(
                                          Icons.add_box_rounded,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83),
                                        ),
                                      ),
                                      Text(_getText('Add Tutes')),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 212, 212, 212)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(100, 70)),
                                        ),
                                        child: Icon(
                                          Icons.playlist_add_rounded,
                                          size: 36,
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
                                        ),
                                      ),
                                      Text(_getText('Add Videos')),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 212, 212, 212)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(100, 70)),
                                        ),
                                        child: Icon(
                                          Icons.assignment,
                                          size: 40,
                                          color: const Color.fromARGB(
                                              255, 83, 83, 83),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 212, 212, 212)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(100, 70)),
                                        ),
                                        child: Icon(
                                          Icons.video_camera_front_rounded,
                                          size: 40,
                                          color:
                                              Color.fromARGB(255, 83, 83, 83),
                                        ),
                                      ),
                                      Text(_getText('Go Live')),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
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
    ;
  }
}
