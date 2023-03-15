import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/filtered_clubs_provider.dart';
import 'package:on_clay/UI/clubAvailabilityRow/club_available_slots.dart';

class ClubsAvailability extends HookConsumerWidget {
  const ClubsAvailability({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final filteredClubs = ref.watch(filteredClubsProvider);
    return Expanded(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: filteredClubs.map((club) {
            return ClubAvailableSlots(club: club);
          }).toList())),
    );
  }
}
