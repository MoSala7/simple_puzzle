part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameUserSucceed extends GameState {}

class GameUserFailed extends GameState {}

class GameSquareTriggerd extends GameState {}

class GameEnabledTrigger extends GameState {}

class GameColorChange extends GameState {}

class GameFinished extends GameState {}
