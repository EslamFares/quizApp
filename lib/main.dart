import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_quiz/cubit/home/home_cubit.dart';
import 'package:question_quiz/cubit/home/home_state.dart';
import 'package:question_quiz/shared/themes/dark_theme.dart';
import 'layout/home/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: darkTheme(),
                home: HomeView(),
              )),
    );
  }
}
