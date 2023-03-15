import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_clay/API/clubs_controller.dart';
import 'package:on_clay/API/selected_filter_providers.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/Models/clubs_groups.dart';

final filteredClubsProvider = Provider((ref) {
  final clubs = ref.watch(ClubsController.provider).clubs;
  final selectedGroup = ref.watch(selectedGroupProvider);
  return filterBySelectedGroup(selectedGroup, clubs);
});

List<ClubData> filterBySelectedGroup(
    ClubsGroup selectedGroup, List<ClubData> clubsList) {
  final filteredClubs = clubsList.where((club) {
    if (selectedGroup.name == 'Wszystkie kluby') {
      return true;
    }

    return selectedGroup.ids.any((id) => id == club.clubPath);
  }).toList();

  return filteredClubs;
}
