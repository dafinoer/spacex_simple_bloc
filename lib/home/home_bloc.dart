import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/services/homeservice.dart';
import 'dart:async';
import 'dart:collection';

// konstan variable
enum ModeType { upcomingLaunch, allLaunch }

class UpcomingBloc {
  final HomeServices _services = HomeServices();

  final _controllUnmodief =
      BehaviorSubject<UnmodifiableListView<SpaceXLaunch>>();

  var datarocket = <SpaceXLaunch>[];

  HashMap<int, List<SpaceXLaunch>> hashMap;

  final modeType = StreamController<ModeType>();

  UpcomingBloc() {
    //cache datarocket
    hashMap = HashMap<int, List<SpaceXLaunch>>();

    // stream untuk upcoming (default)
    _getData(0);

    modeType.stream.listen((modeType) {
      /*
      ketika user berpindah dari current page maka 
      pada method getdata akan mengcheck index dan memanggil network call
      */
      if (ModeType.allLaunch == modeType) {
        _getData(1);
      } else {
        _getData(0);
      }
    });
  }

  Sink<ModeType> get modeTypeSink => modeType.sink;

  Observable<UnmodifiableListView<SpaceXLaunch>> get fetchDataRest =>
      _controllUnmodief.stream;

  _getData(int index) {
    if (index == 0) {
      fetchDataRestUpcoming().then((onValue) {
        _controllUnmodief.add(UnmodifiableListView(datarocket));
      });
    } else {
      fetchDataRestLaunch().then((onValue) {
        _controllUnmodief.add(UnmodifiableListView(datarocket));
      });
    }
  }

  Future<List<SpaceXLaunch>> fetchDataRestUpcoming() async {
    /*
    konsep key dan value ini akan mencheck key, di sini ketika key 1 ada maka 
    lanjut akan langsung di initilize ke variable datarocket
    kemudian di return hashmapnya 
     */
    if (!hashMap.containsKey(1)) {
      print('get print');
      SpaceXLaunchList launchRest = await _services.getRestUpcoming();
      hashMap[1] = launchRest.listData;
    }
    datarocket = hashMap[1];

    return hashMap[1];
  }

  Future<List<SpaceXLaunch>> fetchDataRestLaunch() async {
    if (!hashMap.containsKey(2)) {
      SpaceXLaunchList launchRest = await _services.getRestLaunch();
      hashMap[2] = launchRest.listData;
    }
    datarocket = hashMap[2];

    return hashMap[2];
  }

  void dispose() {
    _controllUnmodief.close();
  }
}
