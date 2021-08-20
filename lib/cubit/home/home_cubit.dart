import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:question_quiz/dummy_data/data.dart';
import 'package:question_quiz/shared/ios_show_dialog.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  //=====================Level ===============

  int allQestionsNum = 5;
  chooseLevel(int level) {
    if (level == 1) {
      allQestionsNum = 5;
    }
    if (level == 2) {
      allQestionsNum = 8;
    }
    if (level == 3) {
      allQestionsNum = 11;
    }
    emit(LevelState());
  }

//========================your degree ==========
  int degree = 0;
  checkDegree(index) {
    bool state = Data.question[qNum]['a'][index]['state'];
    if (state) {
      degree++;
    }
    emit(DegreeState());
  }

  //================== Next Q (queation num)==================
  int qNum = 0;
  addqNum(context) {
    if (qNum + 1 < allQestionsNum) {
      qNum++;
      clearColor();
      clearisClick();
    }
    if (qNum + 1 == allQestionsNum) {
      //==to show Diolog  after choose answer=== important
      if (!isClick) {
        iosShowDialog(
            title: 'Result 🎉🎉',
            subTitle: '$degree / $allQestionsNum',
            context: context,
            onConfirm: () {
              clearAll();
              Navigator.pop(context);
            });
      }
    }
    emit(AddqNumState());
  }

  clearAll() {
    chageTopScore();
    qNum = 0;
    degree = 0;
    clearColor();
    clearisClick();
    emit(AddqNumState());
  }

//====================color==============
  changeborderColor(int index) {
    bool state = Data.question[qNum]['a'][index]['state'];
    bool state1 = Data.question[qNum]['a'][0]['state'];
    bool state2 = Data.question[qNum]['a'][1]['state'];
    bool state3 = Data.question[qNum]['a'][2]['state'];
    bool state4 = Data.question[qNum]['a'][3]['state'];
    if (index == 0) {
      aBColor1 = state ? Colors.green : Colors.red;
      aBColor2 = state2 ? Colors.green : Colors.white;
      aBColor3 = state3 ? Colors.green : Colors.white;
      aBColor4 = state4 ? Colors.green : Colors.white;
    }
    if (index == 1) {
      aBColor2 = state ? Colors.green : Colors.red;
      aBColor1 = state1 ? Colors.green : Colors.white;
      aBColor3 = state3 ? Colors.green : Colors.white;
      aBColor4 = state4 ? Colors.green : Colors.white;
    }
    if (index == 2) {
      aBColor3 = state ? Colors.green : Colors.red;
      aBColor1 = state1 ? Colors.green : Colors.white;
      aBColor2 = state2 ? Colors.green : Colors.white;
      aBColor4 = state4 ? Colors.green : Colors.white;
    }
    if (index == 3) {
      aBColor4 = state ? Colors.green : Colors.red;
      aBColor1 = state1 ? Colors.green : Colors.white;
      aBColor2 = state2 ? Colors.green : Colors.white;
      aBColor3 = state3 ? Colors.green : Colors.white;
    }
    emit(BorderColorState());
  }

  Color aBColor1 = Colors.white;
  Color aBColor2 = Colors.white;
  Color aBColor3 = Colors.white;
  Color aBColor4 = Colors.white;
  Color getColor(index) {
    if (index == 0) return aBColor1;
    if (index == 1) return aBColor2;
    if (index == 2) return aBColor3;
    if (index == 3)
      return aBColor4;
    else
      return aBColor1;
  }

  clearColor() {
    aBColor1 = Colors.white;
    aBColor2 = Colors.white;
    aBColor3 = Colors.white;
    aBColor4 = Colors.white;
    emit(BorderColorState());
  }

//===================choose answer==============
  bool isClick = true;
  changeisClick() {
    isClick = false;
    emit(ChangeIsClickState());
  }

  clearisClick() {
    isClick = true;
    emit(ChangeIsClickState());
  }

  //====================Top Score ================
  int topScore = 0;
  List<Score> topScoreList = [];

  chageTopScore() {
    if (topScore < degree) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('kk:mm:ss - EEE d MMM').format(now);
      topScore = degree;
      topScoreList.add(Score(topScore, formattedDate));
    }
    emit(TopScoreState());
  }
}

class Score {
  final int topScore;
  final String time;

  Score(this.topScore, this.time);
}
