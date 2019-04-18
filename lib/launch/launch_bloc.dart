import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/launch.dart';
import 'package:space_x_new/services/launch_service.dart';
import 'package:space_x_new/utils/utils.dart';

class LunchBloc implements ListSpaceX{
  
  final _controller = BehaviorSubject<UnmodifiableListView<Launch>>();

  final loadMore = StreamController<bool>();

  bool loadingStatus = false;

  final LaunchService _service = LaunchService();

  HashMap<String, List<Launch>> _hashCache = HashMap();

  var dataRocketHistory = <Launch>[];

  LunchBloc(){
    getData(dataRocketHistory.length);
    loadMore.stream.listen((value){
      loadingStatus = value;
    });
  }

  Observable<UnmodifiableListView<Launch>> get fetchstream => _controller.stream;

  void getData(int index) async {
    fetchLaunch(index).then((onvalue){
      _controller.add(UnmodifiableListView(dataRocketHistory));
      loadMore.sink.add(false);
    });
  }

  @override
  Future<List<Launch>> fetchLaunch(int index) async {
    var timeEndquery = DateTime.now().toLocal();

    if (!_hashCache.containsKey('all')){
      List<Launch> launchList = await _service.getRestLaunch(0, timeEndquery.toString());
      _hashCache['all'] = launchList;
    } else if (dataRocketHistory.length != 0){
      List<Launch> launchList = await _service.getRestLaunch(index, timeEndquery.toString());
      if (launchList.length != 0) {
        _hashCache['all'].addAll(launchList.map((f) => f));
      }
    }
    dataRocketHistory = _hashCache['all'];

    return dataRocketHistory;
  }

  @override
  void dispose(){
    _controller.close();
    loadMore.close();
  }

}
