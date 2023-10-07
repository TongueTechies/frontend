import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/screens/home/components/body_english.dart';
import 'package:tongue_techies_frontend/screens/news_screen.dart';
import 'package:tongue_techies_frontend/screens/profile_screen.dart';
import 'package:tongue_techies_frontend/screens/quiz_screen.dart';
import 'package:camera/camera.dart';

class HomeScreenEn extends StatefulWidget {
  const HomeScreenEn({Key? key}) : super(key: key);

  @override
  State<HomeScreenEn> createState() => _HomeScreenEnState();
}

class _HomeScreenEnState extends State<HomeScreenEn> {
  int pageIndex = 0;
  late CameraController _cameraController;

  final pages = [const BodyEn(), News(), QuizScreen(), ProfileScreen()];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.copyWith(),
        ),
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
          if (_cameraController.value.isInitialized) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Camera Preview'),
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                  ),
                  body: Center(
                    child: CameraPreview(_cameraController),
                  ),
                ),
              ),
            );
          }
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

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
