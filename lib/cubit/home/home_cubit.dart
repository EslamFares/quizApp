import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:question_quiz/dummy_data/data.dart';
import 'package:question_quiz/dummy_data/score.dart';
import 'package:question_quiz/shared/ios_show_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  //---------------------------
  late List bigData;
  // = Data.question..shuffle();
  //=====================Level ===============

  int allQestionsNum = 5;
  chooseLevel(int level) {
    if (level == 1) {
      bigData = Data.question..shuffle();
      allQestionsNum = 5;
    }
    if (level == 2) {
      bigData = Data.question..shuffle();
      allQestionsNum = 10;
    }
    if (level == 3) {
      bigData = Data.question..shuffle();
      allQestionsNum = 15;
    }
    emit(LevelState());
  }

//========================your degree ==========
  int degree = 0;
  checkDegree(index) {
    bool state = bigData[qNum]['a'][index]['state'];
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
    bool state = bigData[qNum]['a'][index]['state'];
    bool state1 = bigData[qNum]['a'][0]['state'];
    bool state2 = bigData[qNum]['a'][1]['state'];
    bool state3 = bigData[qNum]['a'][2]['state'];
    bool state4 = bigData[qNum]['a'][3]['state'];
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

  late int topScore;

  late List<Score> topScoreList;
  bool loading = true;
  init() async {
    print('init');
    loading = true;
    emit(LoadingeState());
    //------
    topScoreList = await getTopList();
    emit(TopScoreState());
    topScore = await getTopScoreNum();
    //----------
    loading = false;
    emit(LoadingeState());
  }

  chageTopScore() {
    //<<<<<<<<<<<<<<< store only top >>>>>>>>>>>>>>
    if (topScore < degree) {
      // DateTime now = DateTime.now();
      // String formattedDate = DateFormat('kk:mm:ss - EEE d MMM').format(now);
      topScore = degree;
      // topScoreList.add(Score(topScore: topScore, time: formattedDate));
      // storeTopList();
    }
    //---------- store all result ------------
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss - EEE d MMM').format(now);
    topScoreList.add(Score(topScore: degree, time: formattedDate));
    storeTopList();
    emit(TopScoreState());
  }

  storeTopList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('topScore', Score.encode(topScoreList));
    prefs.setString('topScoreNum', '$topScore');
  }

  //-----------------

}

Future<List<Score>> getTopList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print(prefs.getString('topScore'));
  return prefs.getString('topScore') != null
      ? Score.decode(prefs.getString('topScore').toString())
      : [];
}

Future<int> getTopScoreNum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('topScoreNum'));
  return prefs.getString('topScoreNum') != null
      ? int.parse(prefs.getString('topScoreNum').toString())
      : 0;
}
