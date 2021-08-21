import 'package:flutter/material.dart';
import 'package:question_quiz/cubit/home/home_cubit.dart';
import 'package:question_quiz/dummy_data/score.dart';
import 'package:question_quiz/shared/themes/dark_theme.dart';

class ScoresButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffKey;

  const ScoresButton(this.scaffKey);
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
   late List<Score> reversedScore = cubit.topScoreList.reversed.toList();
    return TextButton(
        onPressed: () {
          scaffKey.currentState!.showBottomSheet((context) => Container(
                height: 250,
                color: dSecColor,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.keyboard_arrow_down)),
                    Expanded(
                      child: Container(
                        child: cubit.loading
                            ? Center(child: CircularProgressIndicator())
                            : cubit.topScoreList.isNotEmpty
                                ? ListView.builder(
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                         reversedScore[index].topScore ==
                                                  cubit.topScore
                                              ? Container(
                                                  width: 10,
                                                  child: Icon(Icons.check))
                                              : Container(
                                                  width: 10,
                                                ),
                                          Text(
                                              'Score: ${reversedScore[index].topScore.toString()}'),
                                          Text(
                                              'Time: ${reversedScore[index].time.toString()}'),
                                        ],
                                      ),
                                    ),
                                    itemCount: cubit.topScoreList.length,
                                  )
                                : Center(child: Text('Play First')),
                      ),
                    ),
                  ],
                ),
              ));
        },
        child: Text('show Score List ↗️↗️'));
  }
}
