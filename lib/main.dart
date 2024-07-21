import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_bloc_3/bloc/counter_bloc.dart';
import 'bloc/user_bloc/user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MultiBlocProviderWrapper(),
    );
  }
}

class MultiBlocProviderWrapper extends StatelessWidget {
  const MultiBlocProviderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Home();
        }
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return Text(
                  state.toString(),
                );
              },
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                final users = state.users;
                final jobs = state.jobs;
                return Column(
                  children: [
                    if (state.isLoading) CircularProgressIndicator(),
                    if (users.isNotEmpty) ...users.map((e) => Text(e.name)),
                    if (jobs.isNotEmpty) ...jobs.map((e) => Text(e.name)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              final usersBloc = BlocProvider.of<UserBloc>(context);
              final counterBloc = BlocProvider.of<CounterBloc>(context);
              usersBloc.add(UserGetCountEvent(counterBloc.state));
            },
            child: Icon(Icons.verified_user),
          ),
          FloatingActionButton(
            onPressed: () {
              final usersBloc = BlocProvider.of<UserBloc>(context);
              final counterBloc = BlocProvider.of<CounterBloc>(context);
              usersBloc.add(UserGetJobEvent(counterBloc.state));
            },
            child: Icon(Icons.supervised_user_circle),
          ),
          FloatingActionButton(
            onPressed: () {
              final counterBloc = BlocProvider.of<CounterBloc>(context);
              counterBloc.add(CounterIncEvent());
            },
            child: Icon(Icons.plus_one),
          ),
          FloatingActionButton(
            onPressed: () {
              final couterBloc = BlocProvider.of<CounterBloc>(context);
              couterBloc.add(CounterDecEvent());
            },
            child: Icon(Icons.exposure_minus_1),
          )
        ],
      ),
    );
  }
}
