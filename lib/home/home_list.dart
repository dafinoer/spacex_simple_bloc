import 'package:flutter/material.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'dart:collection';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_provider.dart';

class HomeListNew extends StatefulWidget {

  HomeListNew({Key key, @required this.bloc}):super(key:key);

  final UpcomingBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeListNew> {

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollController);
  }

  void _scrollController(){
    if (_controller.offset >= _controller.position.maxScrollExtent){
        if (widget.bloc.fullPage == false){
          setState(() {
            widget.bloc.isLoadingContoller.add(true);  
          });
        }
    }
  }

  @override
  Widget build(BuildContext context) {

    final bloc = UpcomingProvider.of(context);

    return StreamBuilder(
      stream: bloc.fetchDataRest,
      builder: (_, snapshot){

        if (snapshot.hasData){
          return _buildList(snapshot, bloc);
        } else if (snapshot.hasError){
          return Center(child: const Text('data'),);
        }
        
        if (bloc.datarocket.length != 0){
          return Container();
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  Widget _buildList(AsyncSnapshot<UnmodifiableListView<SpaceXLaunch>> snapshot, UpcomingBloc bloc) {
    return ListView.separated(
      key: widget.key,
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      separatorBuilder: (_, index) => Divider(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {

        final i = index + 1;
        if (i >= snapshot.data.length && bloc.isLoading == true){
          widget.bloc.getInfinite(i);
          return LinearProgressIndicator();
        }

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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}