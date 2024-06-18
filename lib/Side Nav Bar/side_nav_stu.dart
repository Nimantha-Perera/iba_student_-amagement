import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideNavStu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              "assets/logos/iba_logo.png",
              scale: 1.5,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contact'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              // Close the drawer
              Navigator.pop(context);

              // Clear user data from shared preferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              // Navigate to the login screen
              Navigator.pushReplacementNamed(context, '/student_login');
            },
          ),
        ],
      ),
    );
  }
}
