import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/selected_filter_providers.dart';
import 'package:on_clay/Models/clubs_groups.dart';
import 'package:on_clay/UI/select_group.dart';
import 'package:on_clay/UI/select_group_popup.dart';

class GroupFilterSelectorButton extends HookConsumerWidget {
  const GroupFilterSelectorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final showGroupSelector = useCallback(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SelectClubsGroup();
        },
      );
    }, []);

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SelectGroupButton(
            title: ref.watch(selectedGroupProvider).name,
            onPressed: () {
              showGroupSelector();
            }));
  }
}
