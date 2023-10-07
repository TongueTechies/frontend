import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/helpers/snackbar.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Namaste in Nepal bhasa is called what?',
      'options': ['ज्वजलपा', 'मिसा', 'लसकुस', 'अझ​'],
      'correctAnswer': 'ज्वजलपा',
      'image': 'assets/images/namaste.jpg',
    },
    {
      'question': 'What is the nepal bhasa word for "Thank you"?',
      'options': ['ज्वजलपा', 'सुभाय्', 'लसकुस', 'इनाप'],
      'correctAnswer': 'सुभाय्',
      'image': 'assets/images/thank_you.png',
    },
    {
      'question': 'What does love mean in Nepal Bhasa?',
      'options': ['छेँ ', 'सुभाय्', 'मतीना', 'मिसा'],
      'correctAnswer': 'मतीना',
      'image': 'assets/images/love.jpg',
    },
    {
      'question': 'What is the equivalent meaning of house in Nepal bhasa?',
      'options': ['ज्वजलपा', 'सुभाय्', 'मतीना', 'छेँ'],
      'correctAnswer': 'छेँ',
      'image': 'assets/images/house.jpg',
    },
  ];

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _currentQuestionIndex = 0;
      }
    });
  }

  void _shuffleQuestions() {
    var random = Random();
    for (var i = _questions.length - 1; i > 0; i--) {
      var j = random.nextInt(i + 1);
      var temp = _questions[i];
      _questions[i] = _questions[j];
      _questions[j] = temp;
    }
  }

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nepal Bhasa Quiz'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              _questions[_currentQuestionIndex]['image'],
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _handleAnswer(0);
                  },
                  child: Text(_questions[_currentQuestionIndex]['options'][0]),
                  style: ElevatedButton.styleFrom(
                    primary: kButtonColor,
                    onPrimary: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleAnswer(1);
                  },
                  child: Text(_questions[_currentQuestionIndex]['options'][1]),
                  style: ElevatedButton.styleFrom(
                    primary: kButtonColor,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _handleAnswer(2);
                  },
                  child: Text(_questions[_currentQuestionIndex]['options'][2]),
                  style: ElevatedButton.styleFrom(
                    primary: kButtonColor,
                    onPrimary: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _handleAnswer(3);
                  },
                  child: Text(_questions[_currentQuestionIndex]['options'][3]),
                  style: ElevatedButton.styleFrom(
                    primary: kButtonColor,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleAnswer(int selectedOptionIndex) {
    bool isCorrect = _questions[_currentQuestionIndex]['options']
            [selectedOptionIndex] ==
        _questions[_currentQuestionIndex]['correctAnswer'];
    if (isCorrect) {
      generateSuccessSnackbar("Success", "Correct answer!");
    } else {
      generateErrorSnackbar("Error", "Incorrect answer!");
      return;
    }
    _nextQuestion();
  }
}
