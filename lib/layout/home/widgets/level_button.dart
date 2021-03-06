import 'package:flutter/material.dart';
import 'package:question_quiz/layout/quiz_view/quiz_view.dart';

class LevelButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double? width;
  final Color? color;
  const LevelButton(
      {required this.text, required this.onTap, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                primary: color ?? Colors.blue),
          ),
        ),
      ],
    );
  }
}
