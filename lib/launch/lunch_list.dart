import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_bloc.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/launch/launch_bloc.dart';

class LunchList extends StatefulWidget{

  LunchList({PageStorageKey key, this.bloc}):super(key:key);

  final LunchBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return _LunchState();
  }
} 

class _LunchState extends State<LunchList>{

  ScrollController _scrollController;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(scrollControl);
  }

  void scrollControl(){
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent){
      // if (!widget.bloc.fullPage){
      //   print('tes');
      //   // setState(() {
      //   //   widget.bloc.isLoadingContoller.add(true);
      //   // });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.fetchstream,
      builder: (_, snapshot){
        print('ini print ${snapshot.data}');
        if (snapshot.hasData){
         return _buildList(snapshot);
        } else if (snapshot.hasError){
          print('${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }


  Widget _buildList(AsyncSnapshot<List<SpaceXLaunch>> snapshot) {
    return ListView.separated(
      key: widget.key,
      controller: _scrollController,
      separatorBuilder: (_, index)=> Divider(),
      itemCount: snapshot.data.length,
      itemBuilder: (_, index){
        return ListTile(
          title: Text(snapshot.data[index].missionName),
        );
      },
    );
  }
  
}