import 'dart:convert';
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/clubs_groups.dart';
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

  Future<void> storeClubGroups(List<ClubsGroup> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString('clubGroups', jsonString);
  }

  Future<List<ClubsGroup>> fetchClubGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('clubGroups');
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<ClubsGroup> clubGroups =
          jsonList.map((json) => ClubsGroup.fromJson(json)).toList();
      return clubGroups;
    } else {
      return defaultGroups;
    }
  }

  Future<String> storeSelectedGroupName(String groupName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedGroupName', groupName);
    return groupName;
  }

  Future<String> fetchSelectedGroupName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? groupName = prefs.getString('selectedGroupName');
    if (groupName != null) {
      return groupName;
    } else {
      return defaultGroups[3].name;
    }
  }
}
