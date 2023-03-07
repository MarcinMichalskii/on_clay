import 'package:flutter/material.dart';
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/UI/main_body.dart';
import 'package:on_clay/clubs_data.dart';
import 'package:on_clay/clubs_helper.dart';
import 'package:on_clay/utils/storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  API().setupProxy(proxyDio);
  await API().login();
  final courtsAvailability = await StorageHelper().fetchCourtScheduleDataList();
  runApp(MyApp(courtsAvailability: courtsAvailability));
}

class MyApp extends StatelessWidget {
  final List<CourtScheduleData> courtsAvailability;
  const MyApp({super.key, required this.courtsAvailability});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'On Clay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          MyHomePage(title: 'On Clay', courtsAvailability: courtsAvailability),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.courtsAvailability});

  final String title;
  final List<CourtScheduleData> courtsAvailability;

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

  void _incrementCounter() {
    setState(() {});
  }

  @override
  void initState() {
    getClubsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MainBody(_clubsData, widget.courtsAvailability),
    );
  }
}
