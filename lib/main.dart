import 'package:flutter/material.dart';
import 'package:space_x_new/detail/detail.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_page.dart';
import 'package:space_x_new/home/home_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const primaryColor = Color(0xFF344945);

  @override
  Widget build(BuildContext context) {
    final UpcomingBloc bloc = UpcomingBloc();

    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          canvasColor: primaryColor,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white))
      ),
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
