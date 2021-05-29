import 'package:dio/dio.dart';
import 'package:fetchtosqflite/src/models/human_model.dart';
import 'package:fetchtosqflite/src/providers/db_provider.dart';

class HumanApiProvider {
  Future<List<Human>> getAllHumans() async {
    var url = //"your api link";
    Response response = await Dio().get(url);

    return (response.data as List).map((human) {
      print('Inserting $human');
      DBProvider.db.createHuman(Human.fromJson(human));
    }).toList();
  }
}
