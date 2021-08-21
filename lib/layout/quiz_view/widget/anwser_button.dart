import 'package:flutter/material.dart';

class AnwserButton extends StatelessWidget {
  final int index;
  final Function onTap;
  final Color color;
  final List answer;
  const AnwserButton(
      {required this.answer,
      required this.onTap,
      required this.index,
      required this.color});
  @override
  Widget build(BuildContext context) {
    // HomeCubit cubit = HomeCubit.get(context);
    // List answer = Data.question[cubit.qNum]['a'];
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
