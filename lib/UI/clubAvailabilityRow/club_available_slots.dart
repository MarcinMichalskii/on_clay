import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/selected_filter_providers.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/UI/clubAvailabilityRow/club_available_slots_header.dart';
import 'package:on_clay/UI/tennis_court_block.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/reservations_helper.dart';
import 'package:on_clay/utils/time_helper.dart';

class ClubAvailableSlots extends HookConsumerWidget {
  final ClubData club;

  ClubAvailableSlots({
    required this.club,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final courtsAvailability =
        club.fetchedSchedules[TimeHelper().dateFormattedForAPI(selectedDate)] ??
            [];
    final startTime = ref.watch(selectedStartTimeProvider);
    final endTime = ref.watch(selectedEndTimeProvider);
    final blocks = courtsAvailability
        .map((courtAvailability) {
          final timeBlocks = courtAvailability.mergeTimeBlocks().where(
              (element) => ReservationsHelper.isReservationPossible(
                  element, startTime,
                  endTime: endTime));
          final courtWidgets = timeBlocks.map((timeBlock) {
            return TennisCourtBlock(
              courtName: courtAvailability.courtName,
              courtTime: timeBlock,
              clubPath: club.clubPath,
            );
          }).toList();
          return courtWidgets;
        })
        .expand((element) => element)
        .toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(children: [
        ClubHeader(club: club),
        blocks.isEmpty
            ? Container(
                alignment: Alignment.centerLeft,
                child: Text("Brak wolnych kortów"))
            : Container(
                constraints: BoxConstraints(maxHeight: 80),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: blocks,
                ),
              )
      ]),
    );
  }
}
