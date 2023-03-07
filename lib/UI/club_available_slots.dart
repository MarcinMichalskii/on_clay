import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/API/time_helper.dart';
import 'package:on_clay/clubs_data.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/reservations_helper.dart';

class ClubAvailableSlots extends HookWidget {
  final String club;
  final List<CourtScheduleData> courtsAvailability;
  final TimeOfDay start;
  final TimeOfDay finish;

  ClubAvailableSlots(
      {required this.club,
      required this.courtsAvailability,
      required this.start,
      required this.finish});

  @override
  Widget build(BuildContext context) {
    final blocks = courtsAvailability
        .map((courtAvailability) {
          final timeBlocks = courtAvailability.mergeTimeBlocks().where(
              (element) => ReservationsHelper.isReservationPossible(
                  element, start,
                  endTime: finish));
          final courtWidgets = timeBlocks.map((timeBlock) {
            return TennisCourtWidget(
                courtName: courtAvailability.courtName, courtTime: timeBlock);
          }).toList();
          return courtWidgets;
        })
        .expand((element) => element)
        .toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '$club:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
        blocks.isEmpty
            ? Container(
                alignment: Alignment.centerLeft,
                child: Text("Brak wolnych kortów"))
            : Container(
                constraints: BoxConstraints(maxHeight: 120),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: blocks,
                ),
              )
      ]),
    );
  }
}

class TennisCourtWidget extends StatelessWidget {
  final String courtName;
  final String courtTime;

  TennisCourtWidget({required this.courtName, required this.courtTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            courtName,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 10),
          Text(
            courtTime,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
