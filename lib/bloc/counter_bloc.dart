import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncEvent>(_inc);
    on<CounterDecEvent>(_dec);
  }

  _inc(CounterIncEvent event, Emitter<int> emit) {
    emit(state + 1);
  }

  _dec(CounterDecEvent event, Emitter<int> emit) {
    if (state <= 0) return;
    emit(state - 1);
  }
}

class CounterState {}

class CounterInitial extends CounterState {}

class CounterEvent {}

class CounterIncEvent extends CounterEvent {}

class CounterDecEvent extends CounterEvent {}
