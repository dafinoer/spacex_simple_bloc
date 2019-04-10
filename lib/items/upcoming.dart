import 'package:space_x_new/items/rockets.dart';

class Upcoming {
  final int flightNumber;
  final String missionName;
  final String details;
  final Rockets rockets;
  final String staticFireUtc;
  final int dateUnix;
  final String dateUtc;
  final String dateLocal;

  Upcoming({
    this.flightNumber,
    this.details,
    this.missionName,
    this.rockets,
    this.staticFireUtc,
    this.dateUnix,
    this.dateUtc,
    this.dateLocal
  });

  factory Upcoming.fromJson(Map<String, dynamic> json){
    return Upcoming(
      flightNumber: json['flight_number'],
      missionName: json['mission_name'],
      details: json['details'],
      rockets: Rockets.fromJson(json['rocket']),
      staticFireUtc: json['static_fire_date_utc'],
      dateUnix: json['launch_date_unix'],
      dateUtc: json['launch_date_utc'],
      dateLocal: json['launch_date_local']
    );
  }
}

class UpcomingList {
  final List<Upcoming> upcoming;

  UpcomingList({this.upcoming});

  factory UpcomingList.fromJson(List<dynamic> json){
    return UpcomingList(
      upcoming: json.map((index) => Upcoming.fromJson(index)).toList()
    );
  }
}
