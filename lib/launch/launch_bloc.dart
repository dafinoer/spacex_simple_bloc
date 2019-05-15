import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/launch.dart';
import 'package:space_x_new/services/launch_service.dart';
import 'package:space_x_new/utils/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class LunchBloc {
  final _controller = BehaviorSubject<List<Launch>>();

  final loadMore = StreamController<bool>();

  bool loadingStatus = false;

  final LaunchService _service = LaunchService();

  final _timeEndquery = DateTime.now();

  final _dateFormat = DateFormat('yyyy-MM-dd');

  final HashMap<String, List<Launch>> _hashCache = HashMap();

  int get hadRange => _hashCache['all'] != null ? _hashCache['all'].length : 0;


  LunchBloc() {
    getData(hadRange ?? 0);

    loadMore.stream.listen((value) {
      loadingStatus = value;
    });
  }

  Observable<UnmodifiableListView<Launch>> get fetchstream =>
      _controller.stream.transform(_transformData());

  _transformData() {
    return StreamTransformer<List<Launch>,
        UnmodifiableListView<Launch>>.fromHandlers(handleData: handlerData);
  }

  void handlerData(List<Launch> data, EventSink sink) {
    sink.add(UnmodifiableListView(data.where((launch) => launch.rockets.core.length != 0)));
  }

  void getData(int index) async {
    fetchLaunch(index).then((onvalue) {
      _controller.add(onvalue);
      loadMore.sink.add(false);
    });
  }

  @override
  Future<List<Launch>> fetchLaunch(int index) async {
    if (!_hashCache.containsKey('all')) {
      List<Launch> launchList =
          await _service.getRestLaunch(0, _dateFormat.format(_timeEndquery));
      _hashCache['all'] = launchList;
    } else if (hadRange != 0) {
      List<Launch> launchList = await _service.getRestLaunch(
          index, _dateFormat.format(_timeEndquery));
      if (launchList.length != 0) {
        _hashCache['all'].addAll(launchList.map((f) => f));
      }
    }

    return _hashCache['all'];
  }

  @override
  void dispose() {
    _controller.close();
  }
}
