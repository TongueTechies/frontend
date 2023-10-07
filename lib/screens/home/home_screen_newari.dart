import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/screens/home/components/body_newari.dart';
import 'package:tongue_techies_frontend/screens/news_screen.dart';
import 'package:tongue_techies_frontend/screens/profile_screen.dart';
import 'package:tongue_techies_frontend/screens/quiz_screen.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  int pageIndex = 0;

  final pages = [const BodyNew(), News(), QuizScreen(), ProfileScreen()];

  void onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: pages[pageIndex],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.copyWith()),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.white.withOpacity(0.6),
          currentIndex: pageIndex,
          onTap: onItemTapped,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: "Quiz",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Profile",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle camera button tap
        },
        child: Icon(
          Icons.camera_alt,
        ),
        backgroundColor: kButtonColor,
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
