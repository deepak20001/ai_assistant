import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Prefs {
  static late Box _box;

  static Future<void> initialize() async {
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
    _box = Hive.box(name: 'myData');
  }
}
