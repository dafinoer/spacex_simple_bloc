import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_list.dart';
import 'package:space_x_new/home/home_provider.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeSpaceState();
  }
}

class HomeSpaceState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = UpcomingProvider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming'),
        ),
        body: HomeList(),
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
