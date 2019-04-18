import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:space_x_new/items/launch.dart';
import 'package:space_x_new/launch/launch_bloc.dart';

class LunchList extends StatefulWidget {
  LunchList({PageStorageKey key, this.bloc}) : super(key: key);

  final LunchBloc bloc;

  @override
  State<StatefulWidget> createState() {
    return _LunchState();
  }
}

class _LunchState extends State<LunchList> {
  ScrollController _scrollController;
  final PageStorageBucket _bucket = PageStorageBucket();

  var _imageSpaceXLogo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()..addListener(scrollControl);
    _imageSpaceXLogo = Image.asset(
      'graphics/spacex_logo.jpg',
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }

  void scrollControl() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {

      if (widget.bloc.loadingStatus == false){
        setState(() {});
        widget.bloc.loadMore.add(true);
        widget.bloc.getData(widget.bloc.dataRocketHistory.length);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_imageSpaceXLogo.image, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.fetchstream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot);
        } else if (snapshot.hasError) {
          print('${snapshot.error}');
        } else if (widget.bloc.dataRocketHistory.length > 0) {
          return Container();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(AsyncSnapshot<List<Launch>> snapshot) {
    return ListView.separated(
          key: widget.key,
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          separatorBuilder: (_, index) => Divider(),
          itemCount: snapshot.data.length,
          itemBuilder: (_, index) {

            var imagePacth = snapshot.data[index].links.mission_patch_small;

            final indexList = index + 1 ;

            if (indexList >= snapshot.data.length && widget.bloc.loadingStatus == true){
              return LinearProgressIndicator(backgroundColor: Colors.orange,);
            }

            return ListTile(
              key: ValueKey(snapshot.data[index].flightNumber),
              leading: imagePacth != null
                  ? CircleAvatar(
                      child: CachedNetworkImage(
                          imageUrl: imagePacth,
                        placeholder: (_, url)=> CircularProgressIndicator(),
                        errorWidget: (_, url, error)=> Icon(Icons.error),
                      ),
                      backgroundColor: Colors.black87,
                    )
                  : CircleAvatar(
                      backgroundImage: _imageSpaceXLogo.image,
                      backgroundColor: Colors.black12,
                    ),
              title: Text(snapshot.data[index].missionName),
            );
          },
        );
  }

  Widget _buildCircullarLeading(
      AsyncSnapshot<List<Launch>> snapshot, ImageProvider image) {
    return DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(image: image),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.black12, width: 4.0)));
  }
}
