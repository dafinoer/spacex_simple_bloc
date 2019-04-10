import 'package:flutter/material.dart';
import 'package:space_x_new/home/home_provider.dart';
import 'package:space_x_new/items/upcoming.dart';
import 'package:space_x_new/detail/detail.dart';

class HomeSpace extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = UpcomingProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming'),
      ),
      body: StreamBuilder(
        stream: bloc.fetchUpcoming(),
        builder: (_, snapshot){
          if(snapshot.hasData){
            return _buildList(snapshot);
          }else if (snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          } 
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<UpcomingList> snapshot){
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      separatorBuilder: (_, index)=> Divider(),
      itemCount: snapshot.data.upcoming.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(snapshot.data.upcoming[index].missionName),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => DetailPage(upcoming: snapshot.data.upcoming[index],)
            ));
          },
         );
      },
    );
  }
}