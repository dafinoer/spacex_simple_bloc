import 'dart:async';
import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/items/spacex_launch.dart';

class HomeListNew extends StatefulWidget {
  HomeListNew({Key key, @required this.bloc}) : super(key: key);

  final UpcomingBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeListNew> {
  ScrollController _controller;

  int _page;

  StreamSubscription<ConnectivityResult> _streamSubscription;

  bool _netWorkStatus;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollController);

    _streamSubscription = Connectivity().onConnectivityChanged.listen((onData) {
      if (onData == ConnectivityResult.mobile ||
          onData == ConnectivityResult.wifi) {
        setState(() {
          if (widget.bloc.datarocket.length != 0) {
            widget.bloc.getInfinite(widget.bloc.datarocket.length);
          } else {
            widget.bloc.getData(widget.bloc.datarocket.length);
          }
        });
      }
    });
  }

  void _scrollController() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      if (widget.bloc.isLoading == false) {
        setState(() {
          widget.bloc.isLoadingContoller.add(true);
        });

        widget.bloc.getInfinite(widget.bloc.datarocket.length);

        print(widget.bloc.datarocket.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = UpcomingProvider.of(context);

    return StreamBuilder(
      stream: bloc.fetchDataRest,
      builder: (_, snapshot) {
        print(snapshot.data);

        if (snapshot.hasData) {
          return _buildList(snapshot, bloc);
        } else if (snapshot.hasError) {
          return Center(
            child: const Text('data'),
          );
        }
        if (bloc.datarocket.length != 0) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildList(AsyncSnapshot<UnmodifiableListView<SpaceXLaunch>> snapshot,
      UpcomingBloc bloc) {
    return ListView.separated(
      key: widget.key,
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      separatorBuilder: (_, index) => Divider(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        final i = index + 1;

        if (i >= snapshot.data.length && bloc.isLoading == true) {
          return Center(child: CircularProgressIndicator());
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
    _streamSubscription.cancel();
  }
}
