import 'dart:collection';
import 'package:space_x_new/items/rockets.dart';

class SpaceXLaunch {

  final int flightNumber;
  final String missionName;
  final Rockets rockets;
  final int dateUnix;
  final String dateUtc;
  final String dateLocal;
  final String staticFire;

  SpaceXLaunch({
    this.missionName,
    this.flightNumber,
    this.dateUnix,
    this.rockets,
    this.dateUtc,
    this.dateLocal,
    this.staticFire
  });

  factory SpaceXLaunch.fromJson(Map<String, dynamic> json){
    
    return SpaceXLaunch(
      flightNumber: json['flight_number'],
      missionName:  json['mission_name'],
      dateUnix: json['launch_date_unix'],
      rockets: Rockets.fromJson(json['rocket']),
      dateUtc: json['launch_date_utc'],
      dateLocal: json['launch_date_local'],
      staticFire: json['static_fire_date_utc']
    );
  }
}

class SpaceXLaunchList {

  final List<SpaceXLaunch> listData;
  SpaceXLaunchList({this.listData});

  factory SpaceXLaunchList.fromJson(List<dynamic> json){
    return SpaceXLaunchList(
      listData: json.map((index) => SpaceXLaunch.fromJson(index)).toList()
    );
  }
}