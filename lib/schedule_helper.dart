import 'package:html/dom.dart' as htmlTree;
import 'package:html/parser.dart' show parse;
import 'package:on_clay/API/court_schedule_data.dart';
import 'package:on_clay/API/html_element_helper.dart';
import 'package:on_clay/API/time_helper.dart';

extension GroupAvailableHours on CourtScheduleData {
  List<String> mergeTimeBlocks() {
    List<String> blocks = [];

    if (availableHours.isEmpty) {
      return blocks;
    }
    availableHours.sort();

    String currentBlockStart = availableHours[0];
    String currentBlockEnd = availableHours[0];

    for (int i = 1; i < availableHours.length; i++) {
      String nextTime = availableHours[i];

      DateTime now = DateTime.now();

      DateTime blockEndTime = DateTime.parse('2023-02-24 $currentBlockEnd:00')
          .add(Duration(minutes: timeSpan));

      String blockEndTimeString = blockEndTime.hour.toString().padLeft(2, '0') +
          ':' +
          blockEndTime.minute.toString().padLeft(2, '0');

      if (nextTime == blockEndTimeString) {
        currentBlockEnd = blockEndTimeString;
      } else {
        blocks.add(
            currentBlockStart + ' - ' + addTime(currentBlockEnd, timeSpan));
        currentBlockStart = nextTime;
        currentBlockEnd = nextTime;
      }
    }

    blocks.add(currentBlockStart + ' - ' + addTime(currentBlockEnd, timeSpan));

    return blocks;
  }

  String addTime(String hour, int timeSpan) {
    DateTime dateTime = DateTime.parse('2023-02-24 $hour:00');
    dateTime = dateTime.add(Duration(minutes: timeSpan));
    String newTimeString =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return newTimeString;
  }
}

class ScheduleHelper {
  static List<String> handleClubsList() {
    return [];
  }

  static List<CourtScheduleData> handleSchedule(String htmlData,
      String clubName, String clubPath, DateTime scheduleForDay) {
    final syncTime = DateTime.now();
    var document = parse(htmlData);
    final scheudles = document.getElementsByClassName("schedule");

    List<CourtScheduleData> clubData = [];

    scheudles.forEach((element) {
      final columns = element.getElementsByClassName("schedule_col");

      final hoursColumn = columns.removeLast();
      final hourBoxes =
          hoursColumn.getElementsByClassName("hourboxer").map((e) {
        return e.text;
      }).toList();
      if (hourBoxes.isEmpty) {
        return;
      }

      columns.removeAt(0);

      columns.forEach((element) {
        final courtData = extractAvailableHoursFromColumn(element,
            [...hourBoxes], syncTime, clubName, clubPath, scheduleForDay);
        clubData.add(courtData);
      });
    });
    return clubData;
  }

  static CourtScheduleData extractAvailableHoursFromColumn(
      htmlTree.Element column,
      List<String> hourBoxes,
      DateTime syncTime,
      String clubName,
      String clubPath,
      DateTime day) {
    final availableHours = hourBoxes;
    final timeSpan =
        TimeHelper().getMinutesBetweenHours(hourBoxes.first, hourBoxes[1]);
    final header = column.getElementsByClassName('schedule_header');
    final headerHtml = header.first.innerHtml;
    final courtName = HtmlElementHelper.extractHeaderTitle(headerHtml);

    var values = column.getElementsByClassName('schedule_row');
    values.removeWhere((element) => element.id == '');
    values.where((element) => element.id != '').forEach((element) {
      var newId =
          element.id.substring(element.id.length - 5).replaceAll('_', ':');
      element.id = newId;
      if (element.className.contains('reservation_closed')) {
        availableHours.removeWhere((element) => element == newId);
      }
    });
    final overlappingReservations = column
        .getElementsByClassName("schedule_line")
        .where((element) => element.children.isNotEmpty)
        .toList();

    overlappingReservations.forEach((element) {
      final reservationHeight =
          HtmlElementHelper.extractHeight(element.innerHtml);
      final numberOfReservationBoxes = reservationHeight ~/ 41;
      final reservationStartsAt = element.nextElementSibling?.id ?? '';

      for (var i = 0; i < numberOfReservationBoxes; i++) {
        final reservationTime = TimeHelper()
            .timeIncreasedByTimeSpan(reservationStartsAt, timeSpan * i);
        availableHours.removeWhere((hour) {
          return hour == reservationTime;
        });
      }
    });
    return CourtScheduleData(
        clubName: clubName,
        clubPath: clubPath,
        scheduleForDay: day,
        syncTime: syncTime,
        courtName: courtName,
        availableHours: availableHours,
        timeSpan: timeSpan);
  }
}
