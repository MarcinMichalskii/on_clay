import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_clay/API/dio.dart';
import 'package:on_clay/API/filtered_clubs_provider.dart';
import 'package:on_clay/API/selected_filter_providers.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/Models/court_schedule_data.dart';
import 'package:on_clay/clubs_helper.dart';
import 'package:on_clay/schedule_helper.dart';
import 'package:on_clay/utils/sync_helper.dart';
import 'package:on_clay/utils/time_helper.dart';

part 'clubs_controller.g.dart';

class ClubsController extends StateNotifier<ClubState> {
  static final provider = StateNotifierProvider<ClubsController, ClubState>(
    (ref) {
      ref.listen(selectedDateProvider, (previous, next) {
        final selectedGroup = ref.read(selectedGroupProvider);
        final clubs = ref.notifier.state.clubs;
        ref.notifier.fetchCalendarForClubs(
            filterBySelectedGroup(selectedGroup, clubs), next);
      });
      return ClubsController(ClubState());
    },
  );

  ClubsController(super.state);

  void fetchClubs() async {
    state = ClubState(isLoading: true);
    final data = await API().getClubsList();
    final clubsData = ClubsParser.parseFromHtml(data);
    state = ClubState(isLoading: false, clubs: clubsData);
  }

  void fetchCalendarForClubs(
      List<ClubData> filteredClubs, DateTime date) async {
    state = state.copyWith(isLoading: true);
    Map<String, List<CourtScheduleData>> fetchedSchedules = {};
    for (var club in filteredClubs) {
      if (SyncHelper.shouldSynchornizeFor(club, date)) {
        fetchedSchedules[club.clubPath] =
            await _fetchCalendar(club.clubPath, date);
      }
    }

    final newClubs = state.clubs.map((club) {
      if (fetchedSchedules.containsKey(club.clubPath)) {
        return _updateClubSchedule(club, fetchedSchedules[club.clubPath]!,
            TimeHelper().dateFormattedForAPI(date));
      }
      return club;
    }).toList();
    state = state.copyWith(isLoading: false, clubs: newClubs);
  }

  ClubData _updateClubSchedule(
      ClubData club, List<CourtScheduleData> fetchedSchedules, String date) {
    final newSchedules = club.fetchedSchedules;
    newSchedules[date] = fetchedSchedules;
    return club.copyWith(fetchedSchedules: newSchedules);
  }

  Future<List<CourtScheduleData>> _fetchCalendar(
      String clubPath, DateTime date) async {
    final calendarHTML = await API().getCalendar(date, clubPath);
    final availability = ScheduleHelper.handleSchedule(calendarHTML, date);
    return availability;
  }

  void refreshClubSchedule(String clubPath, DateTime date) async {
    state = state.copyWith(loadingClubId: clubPath);
    final fetchedSchedules = await _fetchCalendar(clubPath, date);
    final newClubs = state.clubs.map((club) {
      if (clubPath == club.clubPath) {
        return _updateClubSchedule(
            club, fetchedSchedules, TimeHelper().dateFormattedForAPI(date));
      }
      return club;
    }).toList();
    state = state.copyWith(loadingClubId: null, clubs: [...state.clubs]);
  }
}

@CopyWith()
class ClubState {
  final String? loadingClubId;
  final bool isLoading;
  final List<ClubData> clubs;

  ClubState(
      {this.loadingClubId, this.isLoading = false, this.clubs = const []});
}
