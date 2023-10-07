import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/helpers/snackbar.dart';
import 'package:tongue_techies_frontend/models/profile.models.dart';
import 'package:tongue_techies_frontend/screens/home/home_screen_english.dart';
import 'package:tongue_techies_frontend/services/profile.service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final profile = await ProfileAPIService().getProfile();
    print(profile);
    if (profile is Profile) {
      setState(() {
        _profile = profile;
      });
    } else {
      Get.off(() => const HomeScreenEn());
      generateErrorSnackbar("Error", "You need to login to access profile!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: _profile != null
          ? Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1521747116042-5a810fda9664'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/previews/005/129/844/non_2x/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Demo User',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(_profile!.data.email),
                ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Anamnagar, Kathmandu'),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                  backgroundColor: kPrimaryColor, color: Colors.white),
            ),
    );
  }
}
