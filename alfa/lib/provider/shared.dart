import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

// 5. list 저장하기
  static Future<void> saveArray(List<dynamic> array) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'finalResultKey';
    final encodedArray = json.encode(array); // 배열을 JSON 문자열로 직렬화
    await prefs.setString(key, encodedArray);
  }

// 6. list 불러오기
  static Future<List<dynamic>> loadArray(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'finalResultKey';
    final encodedArray = prefs.getString(key) ?? '[]'; // 기본값으로 빈 배열 설정
    final decodedArray = json.decode(encodedArray); // JSON 문자열을 배열로 역직렬화
    return List<dynamic>.from(decodedArray);
  }

  static Future<List<Map<String, dynamic>>> loadArray2(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'payInfo';
    final encodedArray = prefs.getString(key) ?? '[]'; // 기본값으로 빈 배열 설정
    final decodedArray = json.decode(encodedArray); // JSON 문자열을 배열로 역직렬화
    return List<Map<String, dynamic>>.from(decodedArray);
  }

  static Future<void> savePayInfo(List<dynamic> array) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'payInfo';
    final encodedArray = json.encode(array); // 배열을 JSON 문자열로 직렬화
    await prefs.setString(key, encodedArray);
  }
}
