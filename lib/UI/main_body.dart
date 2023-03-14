import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:on_clay/Models/clubs_with_availability.dart';
import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/UI/club_available_slots.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/UI/select_group_popup.dart';
import 'package:on_clay/UI/select_date_button.dart';
import 'package:on_clay/UI/select_group.dart';
import 'package:on_clay/clubs_data.dart';
import 'package:on_clay/Models/clubs_groups.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/extensions/date_time_extensions.dart';
import 'package:on_clay/utils/storage_helper.dart';
import 'package:on_clay/utils/sync_helper.dart';
import 'package:on_clay/utils/extensions/time_of_day_extension.dart';
import 'package:on_clay/utils/use_build_effect.dart';
import 'package:collection/collection.dart';

class MainBody extends HookWidget {
  final List<ClubData> clubsData;
  final List<CourtScheduleData> courtsAvailability;
  final List<ClubsGroup> clubsGroups;
  final String initialGroupName;
  const MainBody(this.clubsData, this.courtsAvailability, this.clubsGroups,
      this.initialGroupName);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final clubsGroups = useState(this.clubsGroups);

    useBuildEffect(() {
      StorageHelper().storeClubGroups(clubsGroups.value);
    }, [clubsGroups.value]);
    final selectedGroup = useState<ClubsGroup>(clubsGroups.value
        .firstWhere((element) => element.name == initialGroupName));

    useBuildEffect(() {
      StorageHelper().storeSelectedGroupName(selectedGroup.value.name);
    }, [selectedGroup.value]);

    final filteredClubs = useMemoized(() {
      return clubsData.where((element) {
        if (selectedGroup.value.name == "Wszystkie kluby") {
          return true;
        } else {
          return selectedGroup.value.ids.contains(element.clubPath);
        }
      });
    }, [clubsData, selectedGroup.value]);

    final schedules = useState<List<CourtScheduleData>>([]);
    useBuildEffect(() {
      schedules.value = courtsAvailability;
    }, [courtsAvailability]);
    final selectedDate = useState(DateTime.now());
    final filteredSchedules = useState<List<ClubWithAvailability>>([]);

    final getCalendar = useCallback(() async {
      isLoading.value = true;
      List<CourtScheduleData> currentAvailabilities = [...schedules.value];
      List<CourtScheduleData> newAvailabilities = [];
      for (var club in filteredClubs) {
        if (!SyncHelper.shouldSynchornizeFor(
            club.clubName, selectedDate.value, currentAvailabilities)) {
          continue;
        }
        currentAvailabilities.removeWhere((element) =>
            element.scheduleForDay.isSameDay(selectedDate.value) &&
            element.clubName == club.clubName);
        final calendarHTML =
            await API().getCalendar(selectedDate.value, club.clubPath);
        final availability = ScheduleHelper.handleSchedule(
            calendarHTML, club.clubName, club.clubPath, selectedDate.value);
        newAvailabilities.addAll(availability);
      }
      isLoading.value = false;
      schedules.value = [
        ...currentAvailabilities,
        ...newAvailabilities,
      ];
      StorageHelper().storeCourtScheduleDataList(schedules.value);
    }, [schedules.value, selectedDate.value, filteredClubs]);

    final selectedStartHour = useState(TimeOfDay.now());

    final pickStartHour = useCallback(() async {
      final newHour = await showTimePicker(
        context: context,
        initialTime: selectedStartHour.value,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
      );
      if (newHour != null) {
        selectedStartHour.value = newHour;
      }
    }, [selectedStartHour.value]);

    final selectedEndHour =
        useState<TimeOfDay>(TimeOfDay(hour: 23, minute: 59));
    final pickEndHour = useCallback(() async {
      final newHour = await showTimePicker(
        context: context,
        initialTime: selectedEndHour.value,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
      );

      if (newHour != null) {
        selectedEndHour.value = newHour;
      }
    }, [selectedEndHour.value]);

    useBuildEffect(() {
      if (filteredClubs.isNotEmpty) {
        getCalendar();
      }
    }, [selectedDate.value, filteredClubs]);

    final clubRefreshedData =
        useCallback((ClubData club, List<CourtScheduleData> newData) {
      List<CourtScheduleData> currentAvailabilities = [...schedules.value];
      List<CourtScheduleData> newAvailabilities = [];

      currentAvailabilities.removeWhere((element) =>
          element.scheduleForDay.isSameDay(selectedDate.value) &&
          element.clubName == club.clubName);
      newAvailabilities.addAll(newData);
      schedules.value = [
        ...currentAvailabilities,
        ...newAvailabilities,
      ];
      StorageHelper().storeCourtScheduleDataList(schedules.value);
    }, [schedules.value, selectedDate.value]);

    useBuildEffect(() {
      final filteredAvailability = schedules.value
          .where(
              (element) => element.scheduleForDay.isSameDay(selectedDate.value))
          .toList();
      final mergedByClubName = mergeByClubName(filteredAvailability);
      final filtered = mergedByClubName.where((clubsWithAvailability) =>
          filteredClubs.any((filteredClubs) =>
              filteredClubs.clubName == clubsWithAvailability.club));
      filteredSchedules.value = filtered.toList();
    }, [
      schedules.value,
      selectedStartHour.value,
      selectedEndHour.value,
      selectedGroup.value
    ]);

    final onGroupsListChanged = useCallback((List<ClubsGroup> newGroups) {
      clubsGroups.value = newGroups;
    }, [clubsGroups.value]);

    final showGroupSelector = useCallback(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SelectClubsGroup(
            onGroupSelected: (group) {
              selectedGroup.value = group;
            },
            selectedGroup: selectedGroup.value,
            clubs: clubsData,
            groupsList: clubsGroups.value,
            onGroupsListChanged: onGroupsListChanged,
          );
        },
      );
    }, [selectedGroup.value, clubsData]);

    return Scaffold(
      appBar: AppBar(
        title: Text('On Clay'),
        actions: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SelectGroupButton(
                  title: selectedGroup.value.name,
                  onPressed: () {
                    showGroupSelector();
                  }))
        ],
      ),
      body: Container(
        color: CustomColors.mainBackground,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 140),
                    child: SelectDateButton(
                        dateText: selectedDate.value,
                        headerText: 'Data',
                        onDateSelected: (value) {
                          selectedDate.value = value;
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: FormButtonUI(
                        title: selectedStartHour.value.formattedHoursMinutes,
                        headerText: "Najwcześniej o",
                        onPress: pickStartHour,
                        icon: const Icon(
                          Icons.flight_takeoff_outlined,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: FormButtonUI(
                        title: selectedEndHour.value?.formattedHoursMinutes ??
                            '23:59',
                        headerText: "Najpóźniej do",
                        onPress: pickEndHour,
                        icon: const Icon(
                          Icons.flight_land,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            isLoading.value
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxHeight: 100),
                          margin: EdgeInsets.only(bottom: 128),
                          child: const LoadingIndicator(
                            indicatorType: Indicator.orbit,
                            colors: [CustomColors.orange],
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: filteredSchedules.value
                            .sortedBy((element) => element.club)
                            .map((e) => ClubAvailableSlots(
                                  selectedDate: selectedDate.value,
                                  clubRefreshedData: clubRefreshedData,
                                  club: e.club,
                                  courtsAvailability: e.courtsAvailability,
                                  start: selectedStartHour.value,
                                  finish: selectedEndHour.value ??
                                      TimeOfDay(hour: 23, minute: 59),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
