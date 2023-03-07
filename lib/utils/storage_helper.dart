import 'dart:convert';
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  Future<void> storeCourtScheduleDataList(List<CourtScheduleData> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString('courtScheduleDataList', jsonString);
  }

  Future<List<CourtScheduleData>> fetchCourtScheduleDataList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('courtScheduleDataList');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<CourtScheduleData> courtScheduleDataList =
          jsonList.map((json) => CourtScheduleData.fromJson(json)).toList();
      return courtScheduleDataList;
    } else {
      return [];
    }
  }
}
