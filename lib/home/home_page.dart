import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_list.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/launch/lunch_list.dart';
import 'package:space_x_new/launch/launch_bloc.dart';


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
  Widget build(BuildContext context) {
    final bloc = UpcomingProvider.of(context);
     widgetcollection = [
      HomeListNew(bloc: bloc, key: keyOne,), 
      LunchList(bloc: widget.blocLaunch, key: keyTwo,)
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){},
            ),
          ],
        ),
        body: widgetcollection[_index],
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home), 
                title: Text('home')
                ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.new_releases),
                title: Text('upcoming')
                )
            ],
            currentIndex: _index,
            onTap: (index){
              if (index == 0){
                bloc.modeType.add(ModeType.upcomingLaunch);
              }else {
                bloc.modeType.add(ModeType.allLaunch);
              }
              setState(() {
                _index = index;
              });
            }
        )
    );
  }
}
