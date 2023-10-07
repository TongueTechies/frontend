import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/screens/login/components/body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Scaffold(
        body: Body(),
      ),
    );
  }
}
