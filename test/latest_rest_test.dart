import 'package:flutter_test/flutter_test.dart';
import 'package:space_x_new/services/latest_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:space_x_new/items/latest.dart';
import 'dart:core';

class MockClient extends Mock implements http.Client{}

void main(){
  final Uri uri = Uri.https('api.spacexdata.com', '/v3/launches/next');
  
  test('response mission name', () async{
    final mockClient = MockClient();
    final service = LatestService();

    when(mockClient.get(uri))
    .thenAnswer((_) async => http.Response('{"mission_name": "CRS-17"}', 200));

    expect(await service.getRestLatest(mockClient), isInstanceOf<Latest>());
  });
} 