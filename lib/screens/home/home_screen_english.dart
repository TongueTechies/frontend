import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/screens/home/components/body_english.dart';

class HomeScreenEn extends StatefulWidget {
  const HomeScreenEn({Key? key}) : super(key: key);

  @override
  State<HomeScreenEn> createState() => _HomeScreenEnState();
}

class _HomeScreenEnState extends State<HomeScreenEn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Body(),
      ),
    );
  }
}
