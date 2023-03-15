import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:on_clay/API/clubs_controller.dart';
import 'package:on_clay/API/selected_filter_providers.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/utils/touchable_opacity.dart';

class ClubHeader extends HookConsumerWidget {
  const ClubHeader({Key? key, required this.club}) : super(key: key);

  final ClubData club;

  @override
  Widget build(BuildContext context, ref) {
    final isLoading =
        ref.watch(ClubsController.provider).loadingClubId == club.clubPath;
    final selectedDate = ref.watch(selectedDateProvider);

    final onRefreshClubTapped = useCallback(() {
      ref
          .read(ClubsController.provider.notifier)
          .refreshClubSchedule(club.clubPath, selectedDate);
    }, [club, selectedDate]);
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Text(
              '${club.clubName}:',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          isLoading
              ? Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  height: 24,
                  width: 24,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.orbit,
                    colors: [CustomColors.orange],
                  ))
              : TouchableOpacity(
                  onTap: onRefreshClubTapped,
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
