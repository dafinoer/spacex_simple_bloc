import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_list.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/launch/launch_bloc.dart';
import 'package:space_x_new/launch/lunch_list.dart';

class HomePage extends StatefulWidget {
  final LunchBloc blocLaunch = LunchBloc();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = UpcomingProvider.of(context);
    widgetcollection = [
      HomeListNew(
        bloc: bloc,
        key: keyOne,
      ),
      LunchList(
        bloc: widget.blocLaunch,
        key: keyTwo,
      )
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('FspaceX'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          elevation: 1.0,
        ),
        body: widgetcollection[_index],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xfff9aa33),
            showUnselectedLabels: true,
            unselectedItemColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('home'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.new_releases), title: Text('all')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car), title: Text('vehicle')),
            ],
            currentIndex: _index,
            onTap: (index) {
              if (index == 0) {
                bloc.modeType.add(ModeType.upcomingLaunch);
              } else {
                bloc.modeType.add(ModeType.allLaunch);
              }
              setState(() {
                _index = index;
                bloc.fullPage = false;
              });
            }));
  }
}
