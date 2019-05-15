import 'package:http/http.dart' as http;

abstract class Service {

  Future<dynamic> fetchRest(http.Client client);
}