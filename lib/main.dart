import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_page.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  final UpcomingBloc upcoming  = UpcomingBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      title: 'Flutter SpaceX',
      home: UpcomingProvider(
        upcomingBloc: upcoming,
        child: HomeSpace(),
      ),
    );
  }
}