import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  // 1. 데이터 저장하기

  // 1-1. String 타입 저장
  static Future<void> saveData(
    String key,
    String value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // 1-2. int 타입 저장
  static Future<void> saveData2(
    String key,
    int value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  // 2. 데이터 불러오기

  // 2-1. String 타입 loadData
  static Future<String> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "null";
  }

  // 2-2. int 타입 loadData2
  static Future<int> loadData2(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

// 3.특정 키 데이터 삭제하기
  static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

// 4. 데이터 전부 삭제하기
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
