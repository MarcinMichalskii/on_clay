import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/clubs_controller.dart';
import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/UI/main_body.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/Models/clubs_groups.dart';
import 'package:on_clay/clubs_helper.dart';
import 'package:on_clay/utils/storage_helper.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:on_clay/utils/use_build_effect.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  API().setupProxy(proxyDio);
  await API().setupHeaders();
  await API().login();
  final courtsAvailability = await StorageHelper().fetchCourtScheduleDataList();
  final clubGroups = await StorageHelper().fetchClubGroups();
  final initialGroupName = await StorageHelper().fetchSelectedGroupName();
  runApp(ProviderScope(
      child: OnClayApp(
          courtsAvailability: courtsAvailability,
          clubGroups: clubGroups,
          initialGroupName: initialGroupName)));
}

class OnClayApp extends StatelessWidget {
  final List<CourtScheduleData> courtsAvailability;
  final List<ClubsGroup> clubGroups;
  final String initialGroupName;

  const OnClayApp(
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

class MyHomePage extends HookConsumerWidget {
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
  Widget build(BuildContext context, ref) {
    useBuildEffect(() {
      ref.read(ClubsController.provider.notifier).fetchClubs();
    }, []);
    final _clubsData = ref.watch(ClubsController.provider).clubs;
    return MainBody(
        _clubsData, courtsAvailability, clubsGroups, initialGroupName);
  }
}
