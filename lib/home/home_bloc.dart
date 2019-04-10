import 'package:rxdart/rxdart.dart';
import 'package:space_x_new/items/upcoming.dart';
import 'package:space_x_new/service/upcoming_service.dart';

class UpcomingBloc {

  final UpcomingNetwork _network = UpcomingNetwork();

  Observable<UpcomingList> fetchUpcoming () {
    return Observable<UpcomingList>.fromFuture(_network.fetchData());
  }
}