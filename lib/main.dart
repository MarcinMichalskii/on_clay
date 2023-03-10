import 'package:flutter/material.dart';
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/UI/main_body.dart';
import 'package:on_clay/clubs_data.dart';
import 'package:on_clay/clubs_groups.dart';
import 'package:on_clay/clubs_helper.dart';
import 'package:on_clay/utils/storage_helper.dart';
import 'package:material_color_gen/material_color_gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // API().setupProxy(proxyDio);
  await API().setupHeaders();
  await API().login();
  final courtsAvailability = await StorageHelper().fetchCourtScheduleDataList();
  final clubGroups = await StorageHelper().fetchClubGroups();
  final initialGroupName = await StorageHelper().fetchSelectedGroupName();
  runApp(MyApp(
      courtsAvailability: courtsAvailability,
      clubGroups: clubGroups,
      initialGroupName: initialGroupName));
}

class MyApp extends StatelessWidget {
  final List<CourtScheduleData> courtsAvailability;
  final List<ClubsGroup> clubGroups;
  final String initialGroupName;

  const MyApp(
      {super.key,
      required this.courtsAvailability,
      required this.clubGroups,
      required this.initialGroupName});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Clay',
      theme: ThemeData(
        primarySwatch: CustomColors.darkBlue.toMaterialColor(),
      ),
      home: MyHomePage(
          title: 'On Clay',
          courtsAvailability: courtsAvailability,
          clubsGroups: clubGroups,
          initialGroupName: initialGroupName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.courtsAvailability,
      required this.clubsGroups,
      required this.initialGroupName});

  final String title;
  final List<CourtScheduleData> courtsAvailability;
  final List<ClubsGroup> clubsGroups;
  final String initialGroupName;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ClubData> _clubsData = [];

  getClubsList() async {
    final data = await API().getClubsList();
    setState(() {
      _clubsData = ClubsHelper.handleClubsList(data);
    });
  }

  @override
  void initState() {
    getClubsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(_clubsData, widget.courtsAvailability, widget.clubsGroups,
        widget.initialGroupName);
  }
}
