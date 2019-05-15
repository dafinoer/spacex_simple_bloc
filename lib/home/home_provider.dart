import 'package:flutter/material.dart';
import 'package:space_x_new/home/homebloc.dart';

class HomeProvider extends InheritedWidget {
  HomeProvider({
    Key key,
    Widget child,
    this.bloc,
  })  : assert(bloc != null),
        assert(child != null),
        super(key: key, child: child);

  final HomeBloc bloc;

  @override
  bool updateShouldNotify(HomeProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }

  static HomeProvider of(BuildContext context){
    return context.inheritFromWidgetOfExactType(HomeProvider) as HomeProvider;
  }
}
