import 'package:flutter/material.dart';
import 'package:question_quiz/cubit/home/home_cubit.dart';
import 'package:question_quiz/layout/quiz_view/quiz_view.dart';
import 'package:question_quiz/shared/themes/dark_theme.dart';

import 'widgets/level_button.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        centerTitle: false,
      ),
      body: Container(
        width: w,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text('Select Your Level',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            LevelButton(
              text: 'Easy',
              onTap: () {
                cubit.chooseLevel(1);
              },
              width: w * .35,
            ),
            LevelButton(
                text: 'Meduim',
                onTap: () {
                  cubit.chooseLevel(2);
                }),
            LevelButton(
              text: 'Hard',
              onTap: () {
                cubit.chooseLevel(3);
              },
              width: w * .65,
            ),
            const SizedBox(height: 50),
            Spacer(),
            Text(
              'Top Score : ${cubit.topScore}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Container(
              height: 150,
              color: dSecColor,
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Score: ${cubit.topScoreList[index].topScore.toString()}'),
                      Text('Time: ${cubit.topScoreList[index].time.toString()}'),
                    ],
                  ),
                ),
                itemCount: cubit.topScoreList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
