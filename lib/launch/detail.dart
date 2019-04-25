import 'package:flutter/material.dart';
import 'package:space_x_new/items/launch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:space_x_new/items/rockets.dart';

class DetailLauch extends StatelessWidget {
  DetailLauch({this.launch});

  Launch launch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double _appBarHeigh = 256.0;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeigh,
            backgroundColor: Colors.white,
            title: Text('Falcon'),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Container(
                    color: theme.primaryColor,
                    height: _appBarHeigh / 1,
                    width: double.infinity,
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: DecoratedBox(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundColor: theme.primaryColor,
                              child: CachedNetworkImage(
                                imageUrl: launch.links.mission_patch_small,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.0))))
                ],
              ),
            ),
          ),
          _boxDetail(theme),
          _coreBox(theme),
        ],
      ),
    );
  }

  Widget _boxDetail(ThemeData theme) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Text(
                      'Detail',
                      style: theme.textTheme.title,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      launch.detail,
                      style: theme.textTheme.caption,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.book), onPressed: null),
                    IconButton(icon: Icon(Icons.photo), onPressed: null)
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    ]));
  }

  Widget _coreBox(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 5.0,
            child: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Core',
                        style: theme.textTheme.title,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemExtent: 100,
                      itemCount: launch.rockets.core.length,
                      itemBuilder: (_, index) {
                        return _circleCoreItem(launch.rockets.core[index]);
                      },
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }

  Widget _circleCoreItem(Cores coreName) {
    return Container(
        child: Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(coreName.coreSerial[0]),
          radius: 30.0,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(coreName.coreSerial),
        )
      ],
    ));
  }
}
