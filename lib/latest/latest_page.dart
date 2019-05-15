import 'package:flutter/material.dart';
import 'package:space_x_new/latest/latest_bloc.dart';
import 'package:space_x_new/items/latest.dart';
import 'package:space_x_new/presentation/my_flutter_app_icons.dart';
import 'package:space_x_new/widget/tile_latest.dart';
import 'dart:async';
import 'package:space_x_new/settings/pref_provider.dart';
import 'package:space_x_new/home/home_provider.dart';

enum PopSetup {settings, about}

class LatestPage extends StatefulWidget {

  LatestPage({
    Key key, 
    this.lates
    }):super(key:key);

  LatestBloc lates;

  @override
  State<StatefulWidget> createState() {
    return LatestState();
  }
}

class LatestState extends State<LatestPage>{

  StreamSubscription<Map<String, int>> _subscription;
  String _textDate;


  @override
  void initState() {
    super.initState();
    widget.lates.observerStream.listen((onData){
      _subscribTime(onData.launchDateLocal);
    });

    
  }

  void popMenuSelect(PopSetup value){
    if (PopSetup.settings == value){
      final t = PrefProvider.of(context);
      Navigator.pushNamed(context, '/settings/home', arguments: t.blocpref);

    } else if (PopSetup.about == value){
      print('about');
    }
  }


  void _subscribTime(String date){
    var controller = widget.lates.timeCounter(Duration(seconds: 1), date);
    _subscription = controller.listen((data){
      int tohour24 = data['inHour'] - (data['inDays'] * 24);
     if (data['inHour'] <= 0 && data['inMinutes'] <= 0 && data['inSecond'] == 0){
        _subscription.cancel();
      }
    
      setState(() {
        _textDate ='${data['inDays']}d:${tohour24}h:${data['inMinutes']}m:${data['inSecond']}d';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final sizeQuery = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final test = PrefProvider.of(context);

    final homeProv = HomeProvider.of(context);

    return Scaffold(
      body:CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: sizeQuery.height / 2,
                floating: true,
                pinned: true,
                snap: false,
                actions: <Widget>[
                  PopupMenuButton(
                      onSelected: popMenuSelect,
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<PopSetup>>[
                        PopupMenuItem<PopSetup>(
                          value: PopSetup.settings,
                          child: const Text('Settings'),
                        ),
                        PopupMenuItem<PopSetup>(
                          value: PopSetup.about,
                          child: const Text('About'),
                        ),
                      ]
                  )
                ],
                title: Text('FX'),
                flexibleSpace: FlexibleSpaceBar(
                    title: StreamBuilder(
                      stream: homeProv.bloc.stringObserveble,
                        builder: (_, snapshot){
                          if (snapshot.hasData){
                            return Text(snapshot.data);
                          }
                          return CircularProgressIndicator();
                        }
                    ),
                    centerTitle: true,
                    background: Container(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:Image.asset('graphics/spacex_logo.jpg').image
                            )
                        ),
                      ),
                    )
                ),
              ),

              StreamBuilder<Latest>(
                stream: widget.lates.observerStream,
                builder: (_, snapshot){
                  if (snapshot.hasData){
                    return SliverList(
                        delegate: SliverChildListDelegate([
                          ListTileLates(
                            padding: EdgeInsets.only(top: 8.0),
                            title: Text(snapshot.data.missonName, style: theme.textTheme.title,),
                            subtitle: const Text('Mission Name'),
                            icon: Icon(MyFlutterApp.rocket),
                          ),
                          Divider(),
                          ListTileLates(
                            icon: Icon(Icons.public),
                            title: Text(snapshot.data.rockets.rocketName, style: theme.textTheme.title,),
                            subtitle: Text('${snapshot.data.rockets.rocketName} bring to horizon'),
                          ),
                          Divider(),
                          ListTileLates(
                            icon: Icon(Icons.videocam),
                            title: Text('Streaming', style: theme.textTheme.title,),
                            subtitle: const Text('Youtube link Streaming'),
                          ),
                          Divider(),
                          ListTileLates(
                            icon: Icon(Icons.my_location),
                            title: Text(snapshot.data.launchSite.siteName, style: theme.textTheme.title,),
                            subtitle:Text(snapshot.data.launchSite.siteNameLong),
                          ),
                          Divider(),
                        ])
                    );
                  }

                  return SliverToBoxAdapter(
                    child: Container(
                      height: sizeQuery.height / 4,
                      child: Center(child: CircularProgressIndicator(),),
                    ),
                  );
                },
              )
            ],
          ),);
        }
  }

  ThemeData _defaultTheme() {
    const primaryColor = Color(0xFF344945);
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: primaryColor,
    );
  }