import 'package:space_x_new/items/rockets.dart';
import 'package:space_x_new/items/lunch_site.dart';

class Latest {
  final String missonName;
  final int launchDateUnix;
  final String launchDateUtc;
  final String launchDateLocal;
  final Rockets rockets;
  final LunchSite launchSite;

  Latest(
      {this.missonName,
      this.launchDateUnix,
      this.launchDateUtc,
      this.launchDateLocal,
      this.rockets,
      this.launchSite});

  factory Latest.fromJson(Map<String, dynamic> json) {
    return Latest(
        missonName: json['mission_name'],
        launchDateUnix: json['launch_date_unix'],
        launchDateUtc: json['launch_date_utc'],
        launchDateLocal: json['launch_date_local'],
        rockets: Rockets.fromJson(json['rocket']),
        launchSite: LunchSite.fromJson(json['launch_site']));
  }
}
