import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  // 데이터 저장
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // 데이터 불러오기
  static Future<String> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "데이터 없음";
  }

// 데이터 삭제하기
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
