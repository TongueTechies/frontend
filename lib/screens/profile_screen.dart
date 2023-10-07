import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/models/profile.models.dart';
import 'package:tongue_techies_frontend/models/savedTranslation.models.dart';
import 'package:tongue_techies_frontend/screens/home/home_screen_english.dart';
import 'package:tongue_techies_frontend/services/profile.service.dart';
import 'package:tongue_techies_frontend/services/translation.service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? _profile;
  List<SavedTranslationData>? savedTranslations;

  @override
  void initState() {
    super.initState();
    fetchProfile();
    fetchSavedTranslations();
  }

  Future<void> fetchSavedTranslations() async {
    try {
      var translations =
          await TranslationAPIService().getAllSavedTranslations();
      if (translations is SavedTranslation) {
        setState(() {
          savedTranslations = translations.data;
        });
      } else {
        print("Error fetching saved translations");
      }
    } catch (e) {
      print(e.toString());
    }
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
      print("You need to login to access profile!");
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
      body: Column(
        children: [
          _buildUserProfileSection(),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          _buildSavedTranslationsSection(),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return _profile != null
        ? Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bridge.jpg'),
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
          );
  }

  Widget _buildSavedTranslationsSection() {
    return savedTranslations != null
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Saved Translations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: savedTranslations!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(savedTranslations![index].englishText),
                        subtitle: Text(savedTranslations![index].newariText),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: kPrimaryColor,
            ),
          );
  }
}
