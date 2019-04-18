import 'package:flutter/material.dart';

class LaunchDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Testing'),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([

              ])
          )
        ],
      ),
    );
  }
}