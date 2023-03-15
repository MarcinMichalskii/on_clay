import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:on_clay/UI/multi_select_picker.dart';
import 'package:on_clay/UI/select_group.dart';
import 'package:on_clay/UI/type_text_alert.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/Models/clubs_groups.dart';
import 'package:on_clay/utils/touchable_opacity.dart';
import 'package:collection/collection.dart';

class SelectClubsGroup extends HookWidget {
  SelectClubsGroup();

  @override
  Widget build(BuildContext context) {
    // final groupsList = useState(this.groupsList);
    // final List<MultiSelectItem<String>> listOptions =
    //     clubs.map((e) => MultiSelectItem(e.clubName, e.clubName)).toList();

    // final addNewGroup = useCallback((String groupName) {
    //   final currentGroupsList = [...groupsList.value];
    //   currentGroupsList.add(ClubsGroup(groupName, []));
    //   groupsList.value = currentGroupsList;
    //   onGroupsListChanged(currentGroupsList);
    // }, [groupsList.value, onGroupsListChanged]);

    // final showEditClubGroupName = useCallback((String clubName) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return TypeTextAlert(
    //             headerText: "Nazwa grupy",
    //             clubGroups: groupsList.value,
    //             onConfrimTapped: addNewGroup);
    //       });
    // }, [groupsList.value, addNewGroup]);

    // final showEditClubsInGroup = useCallback((String groupName) {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         final List<MultiSelectItem<ClubData>> listOptions =
    //             clubs.map((e) => MultiSelectItem(e, e.clubName)).toList();
    //         final groupIds = groupsList.value
    //                 .firstWhereOrNull((element) => element.name == groupName)
    //                 ?.ids ??
    //             [];
    //         final selectedOptions = clubs
    //             .where((element) => groupIds.contains(element.clubPath))
    //             .toList();
    //         return MultiSelectPicker(
    //             initialGroupName: groupName,
    //             availableOptions: listOptions,
    //             selectedOptions: selectedOptions,
    //             onConfirm: (selectedOptions, name) {
    //               final currentGroupsList = [...groupsList.value];
    //               final groupIndex = currentGroupsList
    //                   .indexWhere((element) => element.name == groupName);
    //               final newGroup = ClubsGroup(
    //                   name, selectedOptions.map((e) => e.clubPath).toList());
    //               if (groupIndex == -1) {
    //                 currentGroupsList.add(newGroup);
    //               } else {
    //                 currentGroupsList[groupIndex] = newGroup;
    //               }
    //               groupsList.value = currentGroupsList;
    //               onGroupsListChanged(currentGroupsList);
    //             });
    //       });
    // }, [groupsList.value, clubs]);

    return Text('elo');
    //   return AlertDialog(
    //     title: Row(
    //       children: [
    //         Text('Wybież grupę klubów'),
    //         Container(
    //           margin: EdgeInsets.only(left: 4),
    //           child: TouchableOpacity(
    //               onTap: () {
    //                 showEditClubsInGroup('');
    //               },
    //               child: Icon(
    //                 Icons.add,
    //                 size: 16,
    //               )),
    //         ),
    //       ],
    //     ),
    //     content: SingleChildScrollView(
    //       child: ListBody(
    //         children: groupsList.value.map((option) {
    //           return ListTile(
    //             title: Text(option.name),
    //             leading: Radio(
    //               value: option,
    //               groupValue: selectedGroup,
    //               onChanged: (value) {
    //                 onGroupSelected(value as ClubsGroup);
    //                 Navigator.of(context).pop();
    //               },
    //             ),
    //             trailing: option.name == 'Wszystkie kluby'
    //                 ? null
    //                 : Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       if (option.name != selectedGroup.name)
    //                         Container(
    //                           margin: EdgeInsets.only(right: 4),
    //                           child: TouchableOpacity(
    //                               onTap: () {
    //                                 showEditClubsInGroup(option.name);
    //                               },
    //                               child: Icon(
    //                                 Icons.edit,
    //                                 color: CustomColors.gray,
    //                                 size: 16,
    //                               )),
    //                         ),
    //                       if (option.name != selectedGroup.name)
    //                         TouchableOpacity(
    //                             onTap: () {
    //                               final currentGroupsList = [...groupsList.value];
    //                               currentGroupsList.removeWhere(
    //                                   (element) => element.name == option.name);
    //                               groupsList.value = currentGroupsList;
    //                               onGroupsListChanged(currentGroupsList);
    //                             },
    //                             child: Icon(
    //                               Icons.delete,
    //                               size: 16,
    //                               color: CustomColors.orange,
    //                             )),
    //                     ],
    //                   ),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //     actions: <Widget>[
    //       TextButton(
    //         child: Text('ZAMKNIJ'),
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //       ),
    //     ],
    //   );
    // }
  }
}
