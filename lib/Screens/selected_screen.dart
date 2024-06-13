import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iba_app/Languages/languages.dart';
// Import the LanguageManager class

class SelectedScreen extends StatefulWidget {
  const SelectedScreen({Key? key}) : super(key: key);

  @override
  _SelectedScreenState createState() => _SelectedScreenState();
}

class _SelectedScreenState extends State<SelectedScreen> {
  String? _selectedValue;
  final List<String> _dropdownItems = ['English', 'සිංහල', 'தமிழ்'];

  String _getText(String key) {
    return LanguageManager.getText(key); // Utilize the LanguageManager to get translated text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 207, 207, 207),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Color.fromARGB(255, 161, 161, 161),
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        icon: FaIcon(
                          FontAwesomeIcons.globe,
                          size: 15,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        hint: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            _getText('Language'),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        value: _selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue;
                            LanguageManager.selectedLanguage = newValue; // Update selected language in LanguageManager
                          });
                        },
                        underline: Container(),
                        items: _dropdownItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    _getText('Who Are You?'),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(Color.fromARGB(55, 255, 255, 255)),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/student_login');
                          },
                          child: Text(
                            _getText('I\'M A STUDENT'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(200, 50)),
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(Color.fromARGB(55, 255, 255, 255)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/staff_login');
                          },
                          child: Text(
                            _getText('I\'M AN IBA CAMPUS STAFF'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
