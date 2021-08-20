import 'package:flutter/material.dart';
import 'package:question_quiz/cubit/home/home_cubit.dart';
import 'package:question_quiz/dummy_data/data.dart';
import 'package:question_quiz/shared/themes/dark_theme.dart';

class QuizView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    String question = Data.question[cubit.qNum]['q'];
    List answer = Data.question[cubit.qNum]['a'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Q ${cubit.qNum + 1 }'),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              decoration: BoxDecoration(
                  color: dSecColor, borderRadius: BorderRadius.circular(10)),
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
                itemBuilder: (BuildContext context, int index) => AnwserButton(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${cubit.degree} / ${cubit.allQestionsNum}'),
              ],
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                if (!cubit.isClick) {
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

class AnwserButton extends StatelessWidget {
  final int index;
  final Function onTap;
  final Color color;
  const AnwserButton(
      {required this.onTap, required this.index, required this.color});
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    List answer = Data.question[cubit.qNum]['a'];
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
            width: w * .4,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: color, width: 2)),
            child: Center(child: Text(answer[index]['text']))),
      ),
    );
  }
}
