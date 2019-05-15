import 'package:flutter/material.dart';
import 'package:space_x_new/upcoming//detail.dart';
import 'package:space_x_new/home/home_page.dart';
import 'package:flutter/rendering.dart';
import 'package:space_x_new/launch/detail.dart';
import 'package:space_x_new/settings/settings_page.dart';
import 'package:space_x_new/settings/sharedpref.dart';
import 'package:space_x_new/settings/pref_provider.dart';
import 'package:space_x_new/settings/pref_bloc.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  runApp(MyAppNew());
}

class MyAppNew extends StatefulWidget {
  final PrefBloc prefbloc = PrefBloc();

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyAppNew> {
  static const primaryColor = Color(0xFF344945);

  bool _statusMode = false;

  SharedPrefPage _prefPage;

  @override
  void initState() {
    super.initState();
    _prefPage = SharedPrefPage();
  }

  @override
  Widget build(BuildContext context) {
    return PrefProvider(
      blocpref: widget.prefbloc,
      child: MaterialApp(
        title: 'FspaceX',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;

          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => HomePage());

            case '/upcoming/detail':
              return MaterialPageRoute(
                  builder: (_) => DetailPage(
                        spaceXLaunch: arguments,
                      ));

            case '/launch/detail':
              return MaterialPageRoute(
                  builder: (_) => DetailLauch(
                        launch: arguments,
                      ));

            case '/settings/home':
              return MaterialPageRoute(
                  builder: (_) => SettingsPage(bloc: arguments));
          }
        },
      ),
    );
  }

  ThemeData _defaultTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: primaryColor,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.prefbloc.close();
  }
}
