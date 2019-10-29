import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hp_demo1/bloc/homeBloc.dart';

class CountBLoC {
  int _count = 0;
  var _countController = StreamController<int>.broadcast();

  Stream<int> get stream => _countController.stream;
  int get count => _count;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}

class BlocProvider extends InheritedWidget {
  final CountBLoC countBLoC = CountBLoC();
  final HomeBloc homeBloc = HomeBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CountBLoC getCountBloc(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).countBLoC;

  static HomeBloc getHomeBloc(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).homeBloc;
}
