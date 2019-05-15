import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/settings/sharedpref.dart';
import 'dart:async';


class PrefBloc {
  final _prefController = BehaviorSubject<bool>();

  final _settingPref = SharedPrefPage();

  final _streamController = StreamController<bool>();

  PrefBloc(){
    _getPref();
    _streamController.stream.listen((data){
        prefSink.add(data ?? false);
    });
  }

  Observable<bool> get prefObserver => _prefController.stream;

  Sink<bool> get prefSink => _prefController.sink;

  Future<void> _getPref() async {
    var status = await _settingPref.getThemePref();
    _streamController.add(status);
  }

  Future<void> setPref(bool value) async {
    var setPref = await _settingPref.setPrefDark(value);
    bool tes = await _settingPref.getThemePref();

    _streamController.add(tes);
  }

  void close(){
    _streamController.close();
    _prefController.close();
  }

}