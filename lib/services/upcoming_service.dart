import 'package:http/http.dart' as http;
import 'package:space_x_new/items/spacex_launch.dart';
import 'dart:convert';
import 'package:space_x_new/utils/constant.dart';
import 'package:space_x_new/utils/utils.dart';

class UpcomingServices with Constanta implements Query {

  int _offset;

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

  @override
  void setLimit(int offset) {
    // TODO: implement setLimit
  }

  int get indexData => _offset;

  @override
  void setOffset(int offset) {
    _offset = offset;
  }
}