import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_x_new/items/launch.dart';
import 'package:space_x_new/utils/constant.dart';
import 'package:intl/intl.dart';

class LaunchService with Constanta {

  Future<List<Launch>> getRestLaunch(int index, String end) async {
    final uri = Uri.https(Constanta.URL, Constanta.LAUNCH,
        {
          'offset':index.toString(),
          'limit': Constanta.LIMIT,
          'start':'0',
          'end': end
        }
     );

    final response = await http.get(uri);

    if (response.statusCode == 200){
      return Launch.jsonList(json.decode(response.body));
    } else {
      Exception('message');
    }
  }
}