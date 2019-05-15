import 'package:space_x_new/services/latest_service.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:space_x_new/items/latest.dart';
import 'package:intl/intl.dart';


class LatestBloc {

  final _service = LatestService();
  final _controller = PublishSubject<Map<String, int>>();
  final _controllerStreamList = BehaviorSubject<Latest>();

  String dateValue;

  LatestBloc(){
    _getFetch();
  }

  Observable<Map<String, int>> get streamTime => _controller.stream;

  Stream<Map<String, int>> timeCounter(Duration duration, String data){
    StreamController _controller;
    Timer timer;
    final dateTimeConv = DateTime.parse(data).millisecondsSinceEpoch;
    var dateformat = DateFormat('ss');
    var dateFromatMinutes = DateFormat('mm');

    void tick(data){
      var dateTimeNow = DateTime.now().toLocal().millisecondsSinceEpoch;
      if (dateTimeConv < dateTimeNow){
        timer.cancel();
      } else {
        var tot = dateTimeConv - dateTimeNow;
        var remain = Duration(milliseconds: tot);
        _controller.add({
          'inDays':remain.inDays,
          'inHour': remain.inHours, 
          'inMinutes': int.tryParse(dateFromatMinutes.format(
          DateTime.fromMillisecondsSinceEpoch(remain.inMilliseconds)
          )),
          'inSecond': int.tryParse(dateformat.format(
          DateTime.fromMillisecondsSinceEpoch(remain.inMilliseconds)))
        });
      }
    }

    void pause(){
      if (timer != null){
        timer.cancel();
        timer = null;
      }
    }

    void timerStart(){
      timer = Timer.periodic(duration, tick);
    }


    _controller = StreamController<Map<String, int>>(
      onListen: timerStart,
      onCancel:pause,
      onPause: pause,
      onResume: timerStart
    );

    return _controller.stream;
  }

  Observable<Latest> get observerStream => _controllerStreamList.stream;

  _getFetch(){
    shootRestApi().then((onData){
      dateValue = onData.launchDateLocal;
      _controllerStreamList.add(onData);
    });
  }

  Future<Latest> shootRestApi() async {
    var response = await _service.getRestLatest(http.Client());
    return response;
  } 
}