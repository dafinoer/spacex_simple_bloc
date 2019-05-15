import 'package:flutter/material.dart';
import 'package:space_x_new/upcoming/upcoming_bloc.dart';

class UpcomingProvider extends InheritedWidget {

  final UpcomingBloc upcomingBloc;

  UpcomingProvider({
    Key key,
    Widget child,
    this.upcomingBloc
  }) : super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static UpcomingBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(UpcomingProvider) as UpcomingProvider).upcomingBloc;
  }
  
}