import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_puzzle/cubit/game_cubit.dart';
import 'package:simple_puzzle/layout/game_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GameCubit()..initGame(),
        child: MaterialApp(
          title: 'Puzzle Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: GamePage(),
        ));
  }
}
