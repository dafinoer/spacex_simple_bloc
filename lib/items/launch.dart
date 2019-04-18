import 'package:space_x_new/items/links.dart';
import 'package:space_x_new/items/lunch_site.dart';
import 'package:space_x_new/items/spacex_launch.dart';

class Launch extends SpaceXLaunch {

  final Links links;
  final LunchSite lunchSite;

  Launch({
    String mission,
    int dateUnix,
    String dateUtc,
    String dateLocal,
    this.links,
    this.lunchSite
  }):super(missionName:mission, dateUnix:dateUnix, dateUtc:dateUtc, dateLocal:dateLocal);


  factory Launch.fromJson(Map<String, dynamic> json){
    return Launch(
      mission: json['mission_name'],
      dateUnix: json['launch_date_unix'],
      dateLocal: json['launch_date_local'],
      dateUtc: json['launch_date_utc'],
      lunchSite: LunchSite.fromJson(json['launch_site']),
      links: Links.fromJson(json['links'])
    );
  }

  static List<Launch> jsonList(List<dynamic> json){
    List<dynamic> data = json;
    return data.map((f)=> Launch.fromJson(f)).toList();
  }

}