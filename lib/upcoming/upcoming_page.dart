import 'dart:async';
import 'dart:collection';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:space_x_new/upcoming/upcoming_bloc.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/upcoming/search_upcoming.dart';

class HomeListNew extends StatefulWidget {
  HomeListNew({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final UpcomingBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeListNew> {
  ScrollController _controller;
  StreamSubscription<ConnectivityResult> _streamSubscription;
  StreamSubscription<bool> _streamModeTheme;

  @override
  void initState() {
    super.initState();
    _streamSubscription = Connectivity().onConnectivityChanged.listen((onData) {
      if (onData == ConnectivityResult.mobile ||
          onData == ConnectivityResult.wifi) {
        setState(() {
          if (widget.bloc.datarocket.length != 0)
            widget.bloc.getInfinite(widget.bloc.datarocket.length);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = ScrollController()..addListener(()=> _scrollController(widget.bloc));
  }

  void _scrollController(bloc) {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      if (bloc.isLoading == false) {
        setState(() {
          bloc.isLoadingContoller.add(true);
        });
        bloc.getInfinite(bloc.hashMap[1].length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('FX'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: SearchUpcoming(
                  bloc: widget.bloc
              ));
            } ,
          ),
        ],
      ),
      body: StreamBuilder(
      stream: widget.bloc.fetchDataRest,
      builder: (_, snapshot) {

        if (snapshot.hasData) {
          return _buildList(snapshot, widget.bloc, context);
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        if (widget.bloc.datarocket.length != 0) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }

      },
    ),
    );
  }

  Widget _buildList(AsyncSnapshot<UnmodifiableListView<SpaceXLaunch>> snapshot,
      UpcomingBloc bloc, BuildContext context) {

    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        final i = index + 1;

        if (i >= snapshot.data.length && bloc.isLoading == true) return Center(child: CircularProgressIndicator());

        return ListTile(
          key: ValueKey(snapshot.data[index].flightNumber),
          title: Text(snapshot.data[index].missionName, style: Theme.of(context).textTheme.title,),
          onTap: () {
            Navigator.pushNamed(context, '/upcoming/detail',
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
