import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'dart:collection';

class HomeList extends StatelessWidget {

  HomeList({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final bloc = UpcomingProvider.of(context);

    return StreamBuilder(
      stream: bloc.fetchDataRest,
      builder: (_, snapshot){
        if (snapshot.hasData){
          return _buildList(snapshot);
        } else if (snapshot.hasError){
          return Center(child: const Text('data'),);
        } else if (ConnectionState.waiting == snapshot.connectionState){
          return const Center(child: CircularProgressIndicator());
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
  Widget _buildList(AsyncSnapshot<UnmodifiableListView<SpaceXLaunch>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      separatorBuilder: (_, index) => Divider(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(snapshot.data[index].flightNumber),
          title: Text(snapshot.data[index].missionName),
          onTap: () {
            Navigator.pushNamed(context, '/home/detail',
                arguments: snapshot.data[index]);
          },
        );
      },
    );
  }
}