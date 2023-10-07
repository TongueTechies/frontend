import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/screens/login/login_screen.dart';

Drawer makeDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/app_logo.png', height: 100),
              SizedBox(height: 10),
              Text(
                'IndigeTranslate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
        ),
        _buildDrawerItem(Icons.login, 'Login/Register', () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }));
        }),
        _buildDrawerItem(Icons.share, 'Share App', () {
          // Handle Share App action
        }),
        _buildDrawerItem(Icons.star, 'Rate Us', () {
          // Handle Rate Us action
        }),
        _buildDrawerItem(Icons.lock, 'Privacy Policy', () {
          // Handle Privacy Policy action
        }),
        _buildDrawerItem(Icons.feedback, 'Feedback', () {
          // Handle Feedback action
        }),
        Divider(),
        AboutListTile(
          icon: Icon(Icons.info),
          child: Text("Version 1.0.0"),
          applicationName: 'IndigeTranslate',
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2023 IndigeTranslate',
          aboutBoxChildren: <Widget>[
            // Additional AboutBoxChildren can be added here
          ],
        )
      ],
    ),
  );
}

Widget _buildDrawerItem(IconData icon, String text, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16),
    ),
    onTap: onTap,
  );
}
