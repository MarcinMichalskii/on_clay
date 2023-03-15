import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/clubs_controller.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/Models/clubs_groups.dart';
import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/UI/all_clubs_loader.dart';
import 'package:on_clay/UI/clubs_availability.dart';
import 'package:on_clay/UI/clubs_list.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/UI/select_filter_group.dart';
import 'package:on_clay/UI/time_filter_pickers.dart';

class MainBody extends HookConsumerWidget {
  final List<ClubData> clubsData;
  final List<CourtScheduleData> courtsAvailability;
  final List<ClubsGroup> clubsGroups;
  final String initialGroupName;
  const MainBody(this.clubsData, this.courtsAvailability, this.clubsGroups,
      this.initialGroupName);

  @override
  Widget build(BuildContext context, ref) {
    final isLoading = ref.watch(ClubsController.provider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('On Clay'),
        // actions: [GroupFilterSelectorButton()],
      ),
      body: Container(
        color: CustomColors.mainBackground,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const TimeFilterPickers(),
            // Divider(),
            ClubsList(),
            // isLoading ? AllClubsLoader() : ClubsAvailability(),
          ],
        ),
      ),
    );
  }
}
