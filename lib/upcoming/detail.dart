import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/settings/pref_provider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    Key key,
    @required this.spaceXLaunch,
  }) : super(key: key);

  final SpaceXLaunch spaceXLaunch;

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<DetailPage> {
  final DateFormat dateFormat = DateFormat('dd MMM yyy HH:mm');

  String _dateLaunch;
  String _dateStaticFire;

  @override
  void initState() {
    super.initState();

    if (widget.spaceXLaunch.dateLocal!= null){
      var dateLaunch = DateTime.parse(widget.spaceXLaunch.dateLocal).toLocal();
      _dateLaunch = dateFormat.format(dateLaunch) + ' ${dateLaunch.timeZoneName}';
    }
    if (widget.spaceXLaunch.staticFire != null){
      var staticTest = DateTime.parse(widget.spaceXLaunch.staticFire).toLocal();
      _dateStaticFire = dateFormat.format(staticTest) + ' ${staticTest.timeZoneName}';
    }

  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final pref = PrefProvider.of(context);

    return StreamBuilder(
      stream: pref.blocpref.prefObserver,
      builder: (_, snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
          return Theme(
            data:  snapshot.data ? ThemeData(brightness: Brightness.dark) : _defaultTheme(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: query.height / 3,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(widget.spaceXLaunch.missionName),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _tileRocketInfo(theme),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: _buildDate(theme),
                      ),
                      //_horizontalCores()
                    ]),
                  )
                ],
              )),);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _tileRocketInfo(ThemeData theme) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.flight,
            ),
            title: Text('Rocket info',
                style: TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 72.0),
            title: Text(widget.spaceXLaunch.rockets.rocketName),
            subtitle: Text('rocket name'),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 72.0),
            title: Text(widget.spaceXLaunch.rockets.rocketType),
            subtitle: Text('rocket type'),
          )
        ],
      ),
    );
  }

  Widget _buildDate(ThemeData theme) {


    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.event,
            ),
            title: Text('Date Info',
                style: TextStyle(
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 72.0),
            title: Text(_dateLaunch ?? 'coming soon'),
            subtitle: Text('Date Launch'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 72.0),
            title: Text(_dateStaticFire ?? 'coming soon'),
            subtitle: Text('Static Fire'),
          )
        ],
      ),
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
