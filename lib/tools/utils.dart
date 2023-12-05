import 'package:hive/hive.dart';

class Utils{
  late Box boxApp;
  
  Future <void> saveDataToBox(String key, var data) async{
    try {
      boxApp = await Hive.openBox('recordinvest');
      await boxApp.put(key, data);
    } catch (e) {
      //
    }
  }

}