
import 'package:flutter/material.dart';
import 'package:question_quiz/layout/quiz_view/quiz_view.dart';

class LevelButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double? width;
  const LevelButton({required this.text, required this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: width ?? w * .5,
      height: 50,
      margin: EdgeInsets.only(bottom: 25.0),
      child: ElevatedButton(
        onPressed: () {
          onTap();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QuizView()));
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}
