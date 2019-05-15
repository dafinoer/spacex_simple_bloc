import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:space_x_new/items/latest.dart';
import 'package:space_x_new/utils/constant.dart';

class LatestService with Constanta {

  Future<Latest> getRestLatest(http.Client client) async{
    final uri = Uri.https(Constanta.URL, Constanta.LATEST);
    final response = await client.get(uri);

    print(response.statusCode);

    if (response.statusCode == 200){
      return Latest.fromJson(json.decode(response.body));
    }else {
      Exception('Error');
    }
  }
}