import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_puzzle/models/square_puzzle.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  static GameCubit get(context) => BlocProvider.of(context);

  Color wrong = Colors.red;
  Color base = Colors.grey;
  Color succeed = Colors.green;
  Color selected = Colors.blue[400];
  Color toSelect = Colors.yellow;

  bool isSucceed;
  bool enableSelect;
  bool gameFinished;
  int falseCounts;
  var square_puzzles;
  var numbers_list;

  int isSelected;
  int maxSelection = 3;

  generateRandomNo() {
    numbers_list = (List.generate(9, (index) => index)..shuffle())
        .sublist(0, maxSelection);
  }

  initGame() {
    isSelected = 0;
    enableSelect = false;
    Timer(const Duration(seconds: 3), () {
      enableSelection();
    });
    gameFinished = false;
    falseCounts = 0;
    generateRandomNo();
    square_puzzles = List.generate(9,
        (i) => SquarePuzzle(toSelect: numbers_list.contains(i) ? true : false));
    emit(GameInitial());
  }

  squareColor(int i) {
    if (gameFinished) {
      if (numbers_list.contains(i) && square_puzzles[i].toSelect) {
        return succeed;
      } else if (!numbers_list.contains(i) && square_puzzles[i].isSelected) {
        falseCounts += 1;
        return wrong;
      } else {
        return base;
      }
    } else {
      if (enableSelect == false && square_puzzles[i].toSelect) {
        return toSelect;
      } else {
        if (square_puzzles[i].isSelected) {
          return selected;
        } else {
          return base;
        }
      }
    }
  }

  squareSelect(int i) {
    if (square_puzzles[i].isSelected) {
      isSelected -= 1;
    } else {
      isSelected += 1;
    }
    square_puzzles[i].isSelected = !square_puzzles[i].isSelected;
    emit(GameSquareTriggerd());
  }

  enableSelection() {
    enableSelect = true;
    emit(GameEnabledTrigger());
  }

  finishGame() {
    gameFinished = true;
    emit(GameFinished());
  }
}
