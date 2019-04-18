import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/services/upcoming_service.dart';


// konstan variable
enum ModeType { upcomingLaunch, allLaunch }

class UpcomingBloc {

  final UpcomingServices _services = UpcomingServices();

  final _controllUnmodief =
      BehaviorSubject<UnmodifiableListView<SpaceXLaunch>>();

  var datarocket = <SpaceXLaunch>[];

  HashMap<int, List<SpaceXLaunch>> hashMap = HashMap<int, List<SpaceXLaunch>>();

  final modeType = StreamController<ModeType>();

  final isLoadingContoller = StreamController<bool>();

  bool isLoading = false;

  bool fullPage;

  int _index = 0;

  UpcomingBloc() {

    fullPage = false;

    // stream untuk upcoming (default)
    getData(_index);

    isLoadingContoller.stream.listen((onData) {
      isLoading = onData;
    });
  }

  Sink<ModeType> get modeTypeSink => modeType.sink;

  Sink<bool> get modeIsLoading => isLoadingContoller.sink;

  Observable<UnmodifiableListView<SpaceXLaunch>> get fetchDataRest =>
      _controllUnmodief.stream;

  getData(int index) {
    if (index == 0) {
      fetchDataRestUpcoming().then((onValue) {
        _controllUnmodief.add(UnmodifiableListView(datarocket));
      });
    }
  }
  // for infinte list
  getInfinite(int index) async {

    if (_index == 0) {
      
      SpaceXLaunchList spaceXLaunchList = await _services.getRestUpcoming(index);
      if (spaceXLaunchList.listData.length != 0) {
        hashMap[1].addAll(spaceXLaunchList.listData);
        datarocket = hashMap[1];
        _controllUnmodief.add(UnmodifiableListView(datarocket));
      } else {
        fullPage = true;
        _controllUnmodief.add(UnmodifiableListView(datarocket));   
      }
    }
    isLoadingContoller.sink.add(false);
  }

  /*
    konsep key dan value ini akan check key, di sini ketika key 1 ada maka
    lanjut akan langsung di initilize ke variable datarocket
    kemudian di return hashmapnya 
     */
  Future<List<SpaceXLaunch>> fetchDataRestUpcoming() async {
    if (!hashMap.containsKey(1)) {
      SpaceXLaunchList launchRest = await _services.getRestUpcoming(0);
      hashMap[1] = launchRest.listData;
    }
    datarocket = hashMap[1];

    return hashMap[1];
  }

  void dispose() {
    _controllUnmodief.close();
  }
}