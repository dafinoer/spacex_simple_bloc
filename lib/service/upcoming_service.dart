import 'package:space_x_new/items/upcoming.dart';
import 'package:dio/dio.dart';
import 'dart:convert';


class UpcomingNetwork{

  Future<UpcomingList> fetchData() async{
    final dio = Dio();
    final uri = Uri.https(Konstanta.URL, Konstanta.UPCOMING);

    try{
      final respone = await dio.getUri(uri);
      return UpcomingList.fromJson(respone.data);
    } on DioError catch(e){
      print(e);
      if (e.response!=null) {
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }
}

class Konstanta {
  static final URL = 'api.spacexdata.com';
  static final UPCOMING = '/v3/launches/upcoming';
}