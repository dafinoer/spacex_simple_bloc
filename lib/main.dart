import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_page.dart';
import 'package:space_x_new/detail/detail.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final UpcomingBloc bloc = UpcomingBloc();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      title: 'FspaceX',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => UpcomingProvider(
                    upcomingBloc: bloc,
                    child: HomePage(),
                  ),
            );
          case '/home/detail':
            final arguments = settings.arguments;

            return MaterialPageRoute(
                builder: (_) => DetailPage(spaceXLaunch: arguments));
        }
      },
    );
  }
}
