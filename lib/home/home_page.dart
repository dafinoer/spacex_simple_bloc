import 'package:flutter/material.dart';

import 'package:space_x_new/latest/latest_page.dart';
import 'package:space_x_new/upcoming/upcoming_bloc.dart';
import 'package:space_x_new/upcoming/upcoming_page.dart';
import 'package:space_x_new/launch/launch_bloc.dart';
import 'package:space_x_new/launch/lunch_list.dart';
import 'package:space_x_new/latest/latest_bloc.dart';
import 'package:space_x_new/home/homebloc.dart';
import 'package:space_x_new/home/home_provider.dart';

import 'package:space_x_new/settings/pref_provider.dart';

class HomePage extends StatefulWidget {
  final LatestBloc blocLatest = LatestBloc();
  final UpcomingBloc bloc = UpcomingBloc();
  final LunchBloc blocLaunch = LunchBloc();
  final HomeBloc blocHome = HomeBloc();

  @override
  State<StatefulWidget> createState() {
    return HomeSpaceState();
  }
}

class HomeSpaceState extends State<HomePage> {
  int _index = 0;

  final PageStorageKey keyOne = PageStorageKey('pageOne');
  final PageStorageKey keyTwo = PageStorageKey('pageTwo');

  List<Widget> widgetcollection;

  PageStorageBucket bucket = PageStorageBucket();

  bool modeTheme;

  @override
  void initState() {
    super.initState();
    widgetcollection = [

      HomeProvider(
        bloc: widget.blocHome,
        child: LatestPage(
          lates: widget.blocLatest,
        ),
      ),

      HomeListNew(
          bloc: widget.bloc,
          key: keyOne,
      ),
      
      LunchList(
        bloc: widget.blocLaunch,
        key: keyTwo,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final prefBloc = PrefProvider.of(context);

    return StreamBuilder(
        stream: prefBloc.blocpref.prefObserver,
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {

            return Theme(
              data: snapshot.data ? ThemeData(brightness: Brightness.dark) : _defaultTheme(),
              child: Scaffold(
                    body: widgetcollection[_index],
                    bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: const Color(0xfff9aa33),
                        showUnselectedLabels: true,
                        elevation: 2.0,
                        unselectedItemColor: Colors.white,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              icon: Icon(Icons.alarm),
                              title: const Text('latest')),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            title: const Text('upcoming'),
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.new_releases),
                              title: const Text('all')),
                        ],
                        currentIndex: _index,
                        onTap: (index) {
                          setState(() {
                            _index = index;
                            widget.bloc.fullPage = false;
                          });
                        })),);
          } else {
            return Container();
          }
        });
  }

  ThemeData _defaultTheme() {
    const primaryColor = Color(0xFF344945);
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: primaryColor,
    );
  }
}
