import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_puzzle/cubit/game_cubit.dart';
import 'dart:async';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GameCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      itemCount: 9,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            if (cubit.enableSelect) {
                              if (cubit.isSelected < cubit.maxSelection) {
                                cubit.squareSelect(index);
                                if (cubit.isSelected == cubit.maxSelection) {
                                  cubit.finishGame();
                                }
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(color: cubit.squareColor(index)),
                          ),
                        );
                      }),
                  ElevatedButton(
                      onPressed:
                          cubit.gameFinished ? () => cubit.initGame() : null,
                      child: const Text("Restart"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
