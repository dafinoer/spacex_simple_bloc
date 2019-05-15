import 'package:http/http.dart' as http;
import 'package:space_x_new/items/spacex_launch.dart';
import 'dart:convert';
import 'package:space_x_new/utils/constant.dart';
import 'package:space_x_new/utils/utils.dart';

class UpcomingServices extends Service{

  Map<String, String> _maps;


  @override
  Future fetchRest(http.Client client) async {

    final uri = Uri.https(Constanta.URL, Constanta.UPCOMING, _maps);
    final response = await client.get(uri);

    if (response.statusCode == 200){
      return SpaceXLaunchList.fromJson(json.decode(response.body));

    } else {
      throw Exception ('error');
    }
  }

  void setQuery(Map<String, String> query){
    _maps = Map.unmodifiable(query);
  }

}