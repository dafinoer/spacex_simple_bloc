import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/services/upcoming_service.dart';
import 'package:http/http.dart' as http;


// konstan variable
enum ModeType { upcomingLaunch, allLaunch }

class UpcomingBloc {

  final UpcomingServices _services = UpcomingServices();

  final _controllUnmodief =
      BehaviorSubject<List<SpaceXLaunch>>();

  var datarocket = <SpaceXLaunch>[];

  HashMap<int, List<SpaceXLaunch>> hashMap = HashMap<int, List<SpaceXLaunch>>();

  final modeType = StreamController<ModeType>();

  final isLoadingContoller = StreamController<bool>();

  bool isLoading = false;

  bool fullPage;

  int _index = 0;

  UpcomingBloc() {

    fullPage = false;

    getData(_index);

    isLoadingContoller.stream.listen((onData) {
      isLoading = onData;
    });
  }

  Sink<ModeType> get modeTypeSink => modeType.sink;

  Sink<bool> get modeIsLoading => isLoadingContoller.sink;

  Observable<UnmodifiableListView<SpaceXLaunch>> get fetchDataRest =>
      _controllUnmodief.stream.transform(_transformData());

  _transformData(){
    StreamTransformer<List<SpaceXLaunch>, UnmodifiableListView<SpaceXLaunch>> transformer;

    transformer = StreamTransformer.fromHandlers(handleData: (data, EventSink sink){
      sink.add(UnmodifiableListView(data.where((x)=> x.dateLocal != null )));
    });
    return transformer;
  }

  getData(int index) {
    fetchDataRestUpcoming().then((onValue) {
      _controllUnmodief.add(UnmodifiableListView(onValue));
    });
  }

  // for infinte list
  getInfinite(int index) async {
    _services.setQuery({'offset':index.toString(), 'limit':'10'});

      SpaceXLaunchList spaceXLaunchList = await _services.fetchRest(http.Client());

      if (spaceXLaunchList.listData.length != 0) {
        hashMap[1].addAll(spaceXLaunchList.listData);
        _controllUnmodief.add(hashMap[1]);
      } else {
        fullPage = true;
        _controllUnmodief.add(hashMap[1]);
      }

    isLoadingContoller.sink.add(false);
  }

  Future<List<SpaceXLaunch>> fetchDataRestUpcoming() async {
    _services.setQuery({'offset':'0', 'limit':'10'});
    SpaceXLaunchList launchRest = await _services.fetchRest(http.Client());
    hashMap[1] = launchRest.listData;

    return hashMap[1];
  }

  void dispose() {
    _controllUnmodief.close();
    isLoadingContoller.close();
  }
}