import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetCountEvent>(_onGetUsers);
    on<UserGetJobEvent>(_onGetJob);
  }

  _onGetUsers(UserGetCountEvent event, Emitter<UserState> emit) async {
    emit(UserState().copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    //
    final users = List.generate(
      event.usersCout,
      (index) => User(
        name: 'user name',
        id: index.toString(),
      ),
    );
    //
    emit(UserState().copyWith(users: users));
  }

  FutureOr<void> _onGetJob(
      UserGetJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    //
    final jobs = List.generate(
      event.userCount,
      (index) => Job(name: 'Job name', id: index),
    );
    emit(state.copyWith(jobs: jobs));
  }
}
