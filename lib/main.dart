import 'package:flutter/material.dart';
import 'package:space_x_new/detail/detail.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_page.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:space_x_new/launch/detail.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color(0xFF344945);

  @override
  Widget build(BuildContext context) {
    final UpcomingBloc bloc = UpcomingBloc();

    return MaterialApp(
      theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          canvasColor: primaryColor,
          ),
      title: 'FspaceX',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;

        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => UpcomingProvider(
                    upcomingBloc: bloc,
                    child: HomePage(),
                  ),
            );
          case '/home/detail':
            return MaterialPageRoute(
                builder: (_) => DetailPage(spaceXLaunch: arguments));

          case '/launch/detail':
            return MaterialPageRoute(
              builder: (_) => DetailLauch(launch: arguments,));
        }
      },
    );
  }
}
