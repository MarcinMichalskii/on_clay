import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/UI/club_available_slots.dart';
import 'package:on_clay/UI/select_date_button.dart';
import 'package:on_clay/UI/select_group.dart';
import 'package:on_clay/clubs_data.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/date_time_extensions.dart';
import 'package:on_clay/utils/storage_helper.dart';
import 'package:on_clay/utils/sync_helper.dart';
import 'package:on_clay/utils/time_of_day_extension.dart';
import 'package:on_clay/utils/use_build_effect.dart';
import 'package:collection/collection.dart';

class MainBody extends HookWidget {
  final List<ClubData> clubsData;
  final List<CourtScheduleData> courtsAvailability;
  const MainBody(this.clubsData, this.courtsAvailability);

  @override
  Widget build(BuildContext context) {
    final selectedGroup = useState(Group.relaks);

    final filteredClubs = useMemoized(() {
      return clubsData.where((element) {
        if (selectedGroup.value == Group.all) {
          return true;
        } else {
          return selectedGroup.value.groupIds.contains(element.clubPath);
        }
      });
    }, [clubsData, selectedGroup.value]);

    final schedules = useState<List<CourtScheduleData>>([]);
    useBuildEffect(() {
      schedules.value = courtsAvailability;
    }, [courtsAvailability]);
    final selectedDate = useState(DateTime.now());
    final filteredSchedules = useState<List<ClubWithAvailability>>([]);

    final onGroupSelected = useCallback((group) {
      selectedGroup.value = group;
    }, []);

    final getCalendar = useCallback(() async {
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

    final selectedEndHour = useState<TimeOfDay?>(null);
    final pickEndHour = useCallback(() async {
      final newHour = await showTimePicker(
        context: context,
        initialTime: selectedEndHour.value ??
            TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 2),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
      );

      selectedEndHour.value = newHour;
    }, [selectedEndHour.value]);

    useBuildEffect(() {
      if (filteredClubs.isNotEmpty) {
        getCalendar();
      }
    }, [selectedDate.value, filteredClubs]);

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SelectGroup(
              onGroupSelected: onGroupSelected,
              selectedGroup: selectedGroup.value),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 160),
                  child: SelectDateButton(
                      dateText: selectedDate.value,
                      headerText: 'Data',
                      onDateSelected: (value) {
                        selectedDate.value = value;
                      }),
                ),
                TextButton(
                    onPressed: () {
                      pickStartHour();
                    },
                    child: Text(selectedStartHour.value.formattedHoursMinutes)),
                TextButton(
                    onPressed: () {
                      pickEndHour();
                    },
                    child: Text(selectedEndHour.value?.formattedHoursMinutes ??
                        'Najpóźniej o'))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: filteredSchedules.value
                    .map((e) => ClubAvailableSlots(
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
    );
  }
}

List<ClubWithAvailability> mergeByClubName(List<CourtScheduleData> data) {
  final Map<String, List<CourtScheduleData>> mergedData = {};

  for (final item in data) {
    final clubName = item.clubName;

    if (!mergedData.containsKey(clubName)) {
      mergedData[clubName] = [item];
    } else {
      mergedData[clubName]!.add(item);
    }
  }

  final List<ClubWithAvailability> clubsList = [];

  for (final entry in mergedData.entries) {
    clubsList.add(
        ClubWithAvailability(club: entry.key, courtsAvailability: entry.value));
  }

  return clubsList;
}

class ClubWithAvailability {
  final String club;
  final List<CourtScheduleData> courtsAvailability;

  ClubWithAvailability({required this.club, required this.courtsAvailability});
}
