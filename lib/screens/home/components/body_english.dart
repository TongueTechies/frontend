import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tongue_techies_frontend/components/drawer.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/helpers/snackbar.dart';
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/success.models.dart';
import 'package:tongue_techies_frontend/models/translation.models.dart';
import 'package:tongue_techies_frontend/screens/home/components/background.dart';
import 'package:tongue_techies_frontend/screens/home/home_screen_newari.dart';
import 'package:tongue_techies_frontend/services/translation.service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String translation = '';
  bool isLoading = false;
  Errors? errors;
  TextEditingController _textEditingController = TextEditingController();
  AudioPlayer _audioPlayer = AudioPlayer();

  void _handleTranslate() async {
    String text = _textEditingController.text;
    setState(() {
      isLoading = true;
    });

    if (text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      generateErrorSnackbar("Error", "Please input some text!");
      return;
    }

    try {
      dynamic result = await TranslationAPIService().translateNewari(text);
      if (result is TranslationModel) {
        setState(() {
          translation = result.data.translatedText;
          isLoading = false;
        });
      } else if (result is Errors) {
        setState(() {
          errors = result;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      generateErrorSnackbar(
          "Error", "Failed to translate text. Please try again.");
      print("Error: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleTTS() async {
    try {
      dynamic result = await TranslationAPIService().ttsNewari(translation);
      if (result is Success) {
        String audioUrl = "${ApiConstants.baseUrl}${result.data}";
        print(audioUrl);
        await _audioPlayer.setUrl(audioUrl);
        await _audioPlayer.play();
      } else if (result is Errors) {
        setState(() {
          errors = result;
        });
        generateErrorSnackbar("Error", errors!.message);
      }
    } catch (error) {
      generateErrorSnackbar("Error", error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.14;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return Background(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("English to Nepal Bhasa"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        drawer: makeDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Container(
                  width: double.infinity,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/us_circle.png'),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("English"),
                      SizedBox(width: 25),
                      IconButton(
                        icon: Image(
                          image: AssetImage('assets/icons/arrow.png'),
                          height: 20,
                          width: 20,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreenNew();
                          }));
                        },
                      ),
                      Text("Nepal Bhasa"),
                      SizedBox(width: 20),
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/np_circle.png"),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Stack(
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        filled: true,
                        fillColor: kPrimaryLightColor,
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: kPrimaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              BorderSide(color: kPrimaryColor, width: 1),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 18.0),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            translation = '';
                            _textEditingController.text = '';
                          });
                        },
                        icon: Icon(Icons.clear),
                      ),
                      top: 20,
                      right: 5,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: horizontalPadding),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleTranslate,
                    child: isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Translate',
                            style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      // Add shadow to the button
                      elevation: MaterialStateProperty.all(5),
                      shadowColor: MaterialStateProperty.all(kPrimaryColor),
                      // Add highlight to the button
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return kButtonColor.withOpacity(0.5);
                          return kButtonColor; // Use the component's default.
                        },
                      ),
                    ),
                  ),
                ),
              ),
              if (translation.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: Container(
                    margin: EdgeInsets.all(horizontalPadding),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            translation,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontFamily: "NotoSansDevnagari"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () async {
                              _handleTTS();
                            },
                            icon: Icon(
                              Icons.volume_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (translation.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(right: horizontalPadding),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle save translation action
                      },
                      child: Text('Save Translation',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kButtonColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        // Add shadow to the button
                        elevation: MaterialStateProperty.all(5),
                        shadowColor: MaterialStateProperty.all(kPrimaryColor),
                        // Add highlight to the button
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return kButtonColor.withOpacity(0.5);
                            return kButtonColor; // Use the component's default.
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
