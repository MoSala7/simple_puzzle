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

  // Initializing variables and colors used by the game
  Color wrong = Colors.red;
  Color base = Colors.grey;
  Color succeed = Colors.green;
  Color selected = Colors.blue[400];
  Color toSelect = Colors.yellow;

  // more variables to support the game logic

  // it's true when the timer finish to allow user to select squares
  bool enableSelect;
  // it's true when the user select the maximun possible selection which is 3
  bool gameFinished;
  int falseCounts; // it counts how many false counts, not used yet!
  var square_puzzles; // list of the square object
  var numbers_list; // list that contain generated random numbers that the user should select from the puzzle

  int isSelected; // it counts how many squars user has select
  // number of the maximum squares to select by user and the size of the random numbers list
  int maxSelection = 3;

  // function that generates from 0 to 8 unordered then i used the first 3 numbers (maimum selection number)
  generateRandomNo() {
    numbers_list = (List.generate(9, (index) => index)..shuffle())
        .sublist(0, maxSelection);
  }

  // an initializer to activate the timer, initalize used variables, generate a list from the model.
  initGame() {
    isSelected = 0;
    enableSelect = false;
    Timer(const Duration(seconds: 3), () {
      enableSelection();
    });
    gameFinished = false;
    falseCounts = 0;
    generateRandomNo();
    // it generate 3*3 objects and assign true value only from the generated numbers.
    square_puzzles = List.generate(9,
        (i) => SquarePuzzle(toSelect: numbers_list.contains(i) ? true : false));
    emit(GameInitial());
  }

  squareColor(int i) {
    // when game is finished it colorize the correct squares with green and the selected wrong squares with red
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
      // it colorize the and deselected squares.
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

  // a function to know which square is selected and how many squares has been selected so far!
  squareSelect(int i) {
    if (square_puzzles[i].isSelected) {
      isSelected -= 1;
    } else {
      isSelected += 1;
    }
    square_puzzles[i].isSelected = !square_puzzles[i].isSelected;
    emit(GameSquareTriggerd());
  }

// it triggered only after the timer finish to give ability to the user to interact with squares
  enableSelection() {
    enableSelect = true;
    emit(GameEnabledTrigger());
  }

// it triggered only after the user three squares
  finishGame() {
    gameFinished = true;
    emit(GameFinished());
  }
}
