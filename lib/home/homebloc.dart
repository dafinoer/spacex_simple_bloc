import 'package:intl/intl.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/latest.dart';
import 'package:space_x_new/services/latest_service.dart';
import 'package:http/http.dart' as http;

class HomeBloc {
  final _timeController = BehaviorSubject<String>();

  final _controllerEventList = BehaviorSubject<Latest>();

  final _service = LatestService();

  final _dateFormatMinutes = DateFormat('mm');

  final _dateFormatSeconds = DateFormat('ss');

  StreamSubscription<int> _subscription;

  HomeBloc() {
    shootRestApi().then((latest) {
      sinkEventList.add(latest);

      final dateLaunch =
          DateTime.parse(latest.launchDateLocal).millisecondsSinceEpoch;

      _subscription =
          Observable.periodic(Duration(seconds: 1), (i) => i).listen((data) {

            final _dateTimeNow = DateTime.now().toLocal().millisecondsSinceEpoch;

            if (dateLaunch < _dateTimeNow) _subscription.cancel();

            int tot = dateLaunch - _dateTimeNow;
            remainTime(tot);
          });
    });
  }


  Sink<String> get sinkEvent => _timeController.sink;

  Sink<Latest> get sinkEventList => _controllerEventList.sink;

  Observable<String> get stringObserveble => _timeController.stream;

  void remainTime(int total){
    var remain = Duration(milliseconds: total);
    int days = remain.inDays;
    int hours = remain.inHours;
    int minutes = int.tryParse(_dateFormatMinutes.format(DateTime.fromMillisecondsSinceEpoch(remain.inMilliseconds)));
    int seconds = int.tryParse(_dateFormatSeconds.format(DateTime.fromMillisecondsSinceEpoch(remain.inMilliseconds)));

    var txt_text = '${days}d:${hours}h:${minutes}m:${seconds}s';
    sinkEvent.add(txt_text);
  }

  Future<Latest> shootRestApi() async {
    var response = await _service.getRestLatest(http.Client());
    return response;
  }

  void close(){
    _timeController.close();
    _controllerEventList.close();
    _subscription.cancel();
  }

}
