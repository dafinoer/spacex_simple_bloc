import 'package:flutter/material.dart';
import 'package:space_x_new/items/upcoming.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, @required this.upcoming}) : super(key: key);

  final Upcoming upcoming;

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

    if (widget.upcoming.dateLocal!= null){
      var dateLaunch = DateTime.parse(widget.upcoming.dateLocal).toLocal();
      _dateLaunch = dateFormat.format(dateLaunch) + ' ${dateLaunch.timeZoneName}';
    }
    if (widget.upcoming.staticFireUtc != null){
      var staticTest = DateTime.parse(widget.upcoming.staticFireUtc).toLocal();
      _dateStaticFire = dateFormat.format(staticTest) + ' ${staticTest.timeZoneName}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.upcoming.missionName),
            background: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _tileRocketInfo(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: _buildDate(),
            ),
            //_horizontalCores()
          ]),
        )
      ],
    ));
  }

  Widget _tileRocketInfo() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.flight,
              color: Colors.purple,
            ),
            title: Text('Rocket info',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 72.0),
            title: Text(widget.upcoming.rockets.rocketName),
            subtitle: Text('rocket name'),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 72.0),
            title: Text(widget.upcoming.rockets.rocketType),
            subtitle: Text('rocket type'),
          )
        ],
      ),
    );
  }

  Widget _buildDate() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.event,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Date Info',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
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

  Widget _horizontalCores(){
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.upcoming.rockets.core.length,
          itemBuilder: (context, index){
            return _cardItem(widget.upcoming.rockets.core[index].landingVehicle);
          }
      ),
    );
  }

  Widget _cardItem(String title){
    return Container(
      width: 160.0,
      child: Card(
          child: InkWell(
            child: ListTile(
              title: Text(title),
            ),
            splashColor: Colors.blue.withAlpha(30),
            onTap: (){},
          )
      ),
    );
  }

}
