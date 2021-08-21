import 'package:flutter/material.dart';
import 'package:question_quiz/cubit/home/home_cubit.dart';
import 'widgets/level_button.dart';
import 'widgets/scores_button.dart';

class HomeView extends StatelessWidget {
  final scaffKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    var textStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    return Scaffold(
      key: scaffKey,
      appBar: AppBar(
        title: Text('Quiz App'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: w,
        height: h,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select Your Level',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 50),
            LevelButton(
              text: 'Easy (5)',
              onTap: () {
                cubit.chooseLevel(1);
              },
              width: w * .35,
            ),
            LevelButton(
              text: 'Meduim (10)',
              onTap: () {
                cubit.chooseLevel(2);
              },
              color: Colors.amber,
            ),
            LevelButton(
              text: 'Hard (15)',
              onTap: () {
                cubit.chooseLevel(3);
              },
              width: w * .65,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Top Score : ',
                  style: textStyle,
                ),
                cubit.loading
                    ? CircularProgressIndicator()
                    : Text('${cubit.topScore}', style: textStyle),
              ],
            ),
            const SizedBox(height: 70),
            ScoresButton(scaffKey),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
