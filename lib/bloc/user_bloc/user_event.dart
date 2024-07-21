part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserGetCountEvent extends UserEvent{
  final int usersCout;

  UserGetCountEvent(this.usersCout);
}

class UserGetJobEvent extends UserEvent{
  final int userCount;

  UserGetJobEvent(this.userCount);
}
