import 'package:flutter/material.dart';
import 'package:space_x_new/settings/pref_bloc.dart';

class PrefProvider extends InheritedWidget {

  final PrefBloc blocpref;

  PrefProvider({
    Key key,
    this.blocpref,
    Widget child
}) : super(key:key, child:child);

  @override
  bool updateShouldNotify(PrefProvider old) => blocpref != old.blocpref;

  static PrefProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(PrefProvider) as PrefProvider ;
  }

}