import 'package:flutter/material.dart';
import 'package:space_x_new/settings/pref_provider.dart';
import 'package:space_x_new/upcoming/upcoming_bloc.dart';
import 'dart:collection';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/settings/sharedpref.dart';

class SearchUpcoming extends SearchDelegate<String> {
  SearchUpcoming({
    this.bloc,
  });

  final UpcomingBloc bloc;

  final SharedPrefPage sharedPrefPage = SharedPrefPage();

  bool modeTheme;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final pref = PrefProvider.of(context);

    return ThemeData(brightness: Brightness.dark);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    var actions = <Widget>[
      IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')
    ];

    return actions;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      child: Center(child: Text(query),),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<UnmodifiableListView<SpaceXLaunch>>(
      stream: bloc.fetchDataRest,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var list_query = snapshot.data
              .where((test) =>
                  test.missionName.toLowerCase().contains(query.toLowerCase()))
              .toList();

          return ListView.separated(
              itemCount: list_query.length,
              separatorBuilder: (_, index)=> Divider(),
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Icon(Icons.history),
                  title: RichText(
                      text: TextSpan(
                          text: list_query[index].missionName.substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: list_query[index].missionName.substring(query.length),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey))
                      ])),
                  onTap: (){
                    //close(context, list_query[index].missionName);
                    //print(list_query[index].missionName);
                    Navigator.pushNamed(context, '/upcoming/detail',
                        arguments: list_query[index]);

                  },
                );
              });
        }
      },
    );
  }
}
