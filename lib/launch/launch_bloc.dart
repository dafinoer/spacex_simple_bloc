import 'package:space_x_new/services/launch_service.dart';
import 'dart:async';
import 'dart:collection';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:rxdart/rxdart.dart';


class LunchBloc {
  final LaunchService _launchService = LaunchService();

  HashMap<String, List<SpaceXLaunch>> hash;
  
  final _controller = BehaviorSubject<UnmodifiableListView<SpaceXLaunch>>();

  LunchBloc(){
    hash = HashMap();

    fetchLaunch();
    
  }

  Observable<UnmodifiableListView<SpaceXLaunch>> get fetchstream => _controller.stream;

  Future<List<SpaceXLaunch>> fetchLaunch() async{
    if (!hash.containsKey('all')){
      SpaceXLaunchList launchList = await _launchService.getRestLaunch();
      hash['all'] = launchList.listData;
    }
    _controller.add(UnmodifiableListView(hash['all'].map((f)=> f)));
  }
}