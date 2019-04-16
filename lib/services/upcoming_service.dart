import 'package:http/http.dart' as http;
import 'package:space_x_new/items/spacex_launch.dart';
import 'dart:convert';
import 'package:space_x_new/utils/constant.dart';
import 'package:space_x_new/utils/utils.dart';

class UpcomingServices with Constanta{

  Future<SpaceXLaunchList> getRestUpcoming(index) async {
    final uri = Uri.https(Constanta.URL, Constanta.UPCOMING, 
      {
        'offset': index.toString(),
        'limit': '10'
      }
    );
    final response = await http.get(uri);

    if (response.statusCode == 200){
      return SpaceXLaunchList.fromJson(json.decode(response.body));
    } else {
      throw Exception ('error');
    }
  }
}