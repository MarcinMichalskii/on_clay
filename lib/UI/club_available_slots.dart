import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/clubs_data.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/reservations_helper.dart';
import 'package:on_clay/utils/touchable_opacity.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubAvailableSlots extends HookWidget {
  final String club;
  final List<CourtScheduleData> courtsAvailability;
  final TimeOfDay start;
  final TimeOfDay finish;
  final DateTime selectedDate;
  final void Function(ClubData, List<CourtScheduleData>) clubRefreshedData;

  ClubAvailableSlots(
      {required this.club,
      required this.courtsAvailability,
      required this.start,
      required this.finish,
      required this.clubRefreshedData,
      required this.selectedDate});

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
              courtName: courtAvailability.courtName,
              courtTime: timeBlock,
              clubPath: courtAvailability.clubPath,
            );
          }).toList();
          return courtWidgets;
        })
        .expand((element) => element)
        .toList();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(children: [
        ClubHeader(
          club: ClubData(club, courtsAvailability.first.clubPath),
          clubRefreshedData: clubRefreshedData,
          selectedDate: selectedDate,
        ),
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

class ClubHeader extends HookWidget {
  final void Function(ClubData, List<CourtScheduleData>) clubRefreshedData;
  const ClubHeader(
      {Key? key,
      required this.club,
      required this.clubRefreshedData,
      required this.selectedDate})
      : super(key: key);

  final ClubData club;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final onRefreshClubTapped = useCallback((ClubData club) async {
      List<CourtScheduleData> newAvailabilities = [];

      final calendarHTML = await API().getCalendar(selectedDate, club.clubPath);
      final availability = ScheduleHelper.handleSchedule(
          calendarHTML, club.clubName, club.clubPath, selectedDate);
      newAvailabilities.addAll(availability);
      isLoading.value = false;
      clubRefreshedData(club, newAvailabilities);
    }, [club, selectedDate]);
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Text(
              '${club.clubName}:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          isLoading.value
              ? Container(
                  margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  height: 24,
                  width: 24,
                  child: LoadingIndicator(
                    indicatorType: Indicator.orbit,
                    colors: [CustomColors.orange],
                  ))
              : TouchableOpacity(
                  onTap: () {
                    isLoading.value = true;
                    onRefreshClubTapped(club);
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: const Icon(
                        Icons.sync,
                        color: Colors.black,
                        size: 24,
                      )),
                )
        ],
      ),
    );
  }
}

class TennisCourtWidget extends StatelessWidget {
  final String clubPath;
  final String courtName;
  final String courtTime;

  TennisCourtWidget(
      {required this.courtName,
      required this.courtTime,
      required this.clubPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse('https://www.twojtenis.pl/pl/kluby/$clubPath.html'),
            mode: LaunchMode.externalApplication);
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: CustomColors.orange,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courtName,
                style: TextStyle(
                    fontSize: 14,
                    color: CustomColors.superLightGray,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 4),
              Text(
                courtTime,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.superLightGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
