import 'package:http/http.dart' as http;
import 'package:space_x_new/items/spacex_launch.dart';
import 'dart:convert';
import 'package:space_x_new/utils/constant.dart';
import 'package:space_x_new/utils/utils.dart';

class LaunchService with Constanta implements Query {

  int _offset;

  
  Future<SpaceXLaunchList> getRestLaunch(int offset) async {
    final uri = Uri.https(Constanta.URL, Constanta.LAUNCH,
        {
          'offset':offset.toString(),
          'limit':'9'
        }
     );
    final response = await http.get(uri);

    if (response.statusCode == 200){
      return SpaceXLaunchList.fromJson(json.decode(response.body));
    } else {
      Exception('message');
    }
  }

  @override
  void setOffset(int offset) {
    _offset = offset;
  }

  @override
  void setLimit(int offset) {
    // TODO: implement setLimit
  }


}