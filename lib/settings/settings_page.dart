import 'package:flutter/material.dart';
import 'package:space_x_new/settings/pref_provider.dart';
import 'package:space_x_new/settings/pref_bloc.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({
    this.bloc
  });

  final PrefBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<SettingsPage> {
  bool mode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pref = PrefProvider.of(context);

    return StreamBuilder(
      stream: pref.blocpref.prefObserver,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('this is ${snapshot.data}');
          return Theme(
              data: snapshot.data
                  ? ThemeData(brightness: Brightness.dark)
                  : _defaultTheme(),
              child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Settings'),
                  ),
                  body: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView(
                      children: <Widget>[
                        SwitchListTile(
                          title: const Text('Dark mode'),
                          value: snapshot.data,
                          activeColor: const Color(0xfff9aa33),
                          subtitle: const Text('Settings dark mode'),
                          onChanged: (bool value) {
                            print('on change ${value}');
                            pref.blocpref.setPref(value);
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text('About'),
                          onTap: () => print('about'),
                        ),
                        Divider(),
                      ],
                    ),
                  )));
        } else {
          return Container();
        }
      },
    );
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
