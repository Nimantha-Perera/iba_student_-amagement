import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iba_app/Languages/languages.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({Key? key}) : super(key: key);

  String _getText(String key) {
    return LanguageManager.getText(
        key); // Utilize the LanguageManager to get translated text
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _password = TextEditingController();
    TextEditingController _index = TextEditingController();
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
                            _getText("Login your student portal"),
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

                  // Add some space between the title and text fields
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
                              color: Colors
                                  .grey[200], // Set background color to gray
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                            child: TextField(
                              controller: _index,

                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Allow only digits
                                LengthLimitingTextInputFormatter(
                                    10), // Limit input length to 10 characters
                              ],
                              keyboardType: TextInputType
                                  .number, // Set keyboard type to number
                              decoration: InputDecoration(
                                labelText: _getText("Index Number"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set border radius
                                  borderSide: BorderSide(
                                    width: 10.0, // Set border width
                                    // Set border color to match background
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                            height:
                                10), // Add some space between the text fields
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .grey[200], // Set background color to gray
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set border radius
                            ),
                            child: TextField(
                              controller: _password,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: _getText(
                                  "Password",
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Set border radius
                                  borderSide: BorderSide(
                                    width: 10.0, // Set border width
                                    // Set border color to match background
                                  ),
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
                                  value: false, // Set initial value of checkbox
                                  onChanged: (value) {
                                    // Handle checkbox value change
                                    if (value == true) {
                                      // Add functionality for "Keep me signed in" checkbox
                                    } else {
                                      // Remove functionality for "Keep me signed in" checkbox
                                    }
                                  },
                                ),
                                Text(
                                  _getText("Keep me signed in"),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                // Add functionality for "Forgot your password? Reset now" link
                              },
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
                        onPressed: () {
                          // Add functionality for login button
                          String index = _index.text;
                          String password = _password.text;

                          checkLogin(context, index, password);
                        },
                        child: Text(
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
  
void checkLogin(BuildContext context, String index, String password) {
  if (index == '123456' && password == '123456') {
    Navigator.pushNamed(context, '/selected');
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },  
            )
          ],
        );
      },
    );
  }
}
}


