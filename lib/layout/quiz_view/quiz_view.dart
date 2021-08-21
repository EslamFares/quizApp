import 'dart:async';

import 'package:flutter/material.dart';
import 'package:question_quiz/cubit/home/home_cubit.dart';
import 'package:question_quiz/layout/quiz_view/widget/anwser_button.dart';
import 'package:question_quiz/shared/themes/dark_theme.dart';

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    String question = cubit.bigData[cubit.qNum]['q'];
    List answer = cubit.bigData[cubit.qNum]['a'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question num ${cubit.qNum + 1}'),
        leading: IconButton(
            onPressed: () {
              cubit.clearAll();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: w,
        height: h,
        child: ListView(
          children: [
            SizedBox(height: 50),
            ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 50,
                      decoration: BoxDecoration(
                          color: dSecColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(question),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: answer.length,
                        itemBuilder: (BuildContext context, int index) =>
                            AnwserButton(
                                answer: answer,
                                color: cubit.getColor(index),
                                index: index,
                                onTap: () {
                                  if (cubit.isClick) {
                                    cubit.changeborderColor(index);
                                    cubit.changeisClick();
                                    cubit.checkDegree(index);
                                  } else
                                    print('click done..');
                                }),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${cubit.degree} / ${cubit.allQestionsNum}',
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                if (!cubit.isClick) {
                  _controller.reverse();
                  Timer(Duration(milliseconds: 500), () {
                    _controller.forward();
                  });
                  cubit.addqNum(context);
                } else {
                  print('next Q no');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('choose answer first❗❗'),
                    behavior: SnackBarBehavior.floating,
                    width: w * .6,
                  ));
                }
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: Icon(Icons.arrow_forward_ios)),
            )
          ],
        ),
      ),
    );
  }
}
