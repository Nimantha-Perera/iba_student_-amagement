import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iba_app/Languages/languages.dart';
import 'package:iba_app/Stu_Screens/StudentData.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  @override
  _StudentLoginScreenState createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _index = TextEditingController();
  bool _isLoading = false;
  bool _keepMeSignedIn = false;

  @override
  void initState() {
    super.initState();
    _loadKeepMeSignedIn();
  }

  void _loadKeepMeSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _keepMeSignedIn = prefs.getBool('keepMeSignedIn') ?? false;
      if (_keepMeSignedIn) {
        _index.text = prefs.getString('index') ?? '';
        _password.text = prefs.getString('password') ?? '';
        if (_index.text.isNotEmpty && _password.text.isNotEmpty) {
          checkLogin(context, _index.text, _password.text);
        }
      }
    });
  }

  void _saveKeepMeSignedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('keepMeSignedIn', value);
    if (value) {
      prefs.setString('index', _index.text);
      prefs.setString('password', _password.text);
    } else {
      prefs.remove('index');
      prefs.remove('password');
    }
  }

  String _getText(String key) {
    return LanguageManager.getText(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getText("Login Your \nStudent Portal"),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _getText(
                                "IBA Campus already registered students only"),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              controller: _index,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: _getText("Index Number"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              controller: _password,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: _getText("Password"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.black,
                                  value: _keepMeSignedIn,
                                  onChanged: (value) {
                                    setState(() {
                                      _keepMeSignedIn = value!;
                                      _saveKeepMeSignedIn(value);
                                    });
                                  },
                                ),
                                Text(
                                  _getText("Keep me signed in"),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                _getText("Forgot your password"),
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          overlayColor: MaterialStateProperty.all(
                              Color.fromARGB(55, 255, 255, 255)),
                          minimumSize: MaterialStateProperty.all(Size(200, 50)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () {
                                String index = _index.text;
                                String password = _password.text;
                                checkLogin(context, index, password);
                              },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                _getText('LOGIN'),
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkLogin(BuildContext context, String index, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('index', isEqualTo: index)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        showErrorDialog(context, 'Login Failed', 'Invalid index number.');
        print('Error:$userSnapshot');
      } else {
        final userData = userSnapshot.docs.first.data();
        if (userData['password'] == password) {
          if (_keepMeSignedIn) {
            _saveKeepMeSignedIn(true);
          }
          Navigator.pushNamed(context, '/student_portal', arguments: StudentData(index,userData));
        } else {
          showErrorDialog(context, 'Login Failed', 'Invalid password.');
        }
      }
    } catch (e) {
      showErrorDialog(context, 'Error', 'An error occurred. Please try again.$e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
              },
            )
          ],
        );
      },
    );
  }
}
