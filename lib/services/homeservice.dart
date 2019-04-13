import 'package:http/http.dart' as http;
import 'package:space_x_new/items/spacex_launch.dart';
import 'package:space_x_new/utils/utils.dart';
import 'dart:convert';

class HomeServices with Value{

  Future<SpaceXLaunchList> getRestUpcoming() async {
    final uri = Uri.https(URL, UPCOMING);
    final response = await http.get(uri);

    if (response.statusCode == 200){
      return SpaceXLaunchList.fromJson(json.decode(response.body));
    } else {
      throw Exception ('error');
    }
  }

  Future<SpaceXLaunchList> getRestLaunch() async {
    final uri = Uri.https(URL, LAUNCH);
    final response = await http.get(uri);

    if (response.statusCode == 200){
      return SpaceXLaunchList.fromJson(json.decode(response.body));
    } else {
      Exception('message');
    }
  }
}