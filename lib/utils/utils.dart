import 'package:space_x_new/items/launch.dart';


abstract class ListSpaceX {

  Future<List<Launch>> fetchLaunch(int index) {}

  void dispose(){}

}