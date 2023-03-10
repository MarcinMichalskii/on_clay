import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:on_clay/UI/colors.dart';

class MultiSelectPicker<Data> extends HookWidget {
  const MultiSelectPicker(
      {super.key,
      required this.availableOptions,
      required this.selectedOptions,
      required this.onConfirm,
      this.initialGroupName});
  final void Function(List<Data>, String) onConfirm;
  final List<MultiSelectItem<Data>> availableOptions;
  final List<Data> selectedOptions;
  final String? initialGroupName;

  @override
  Widget build(BuildContext context) {
    final groupName = useState(initialGroupName ?? '');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MultiSelectDialog(
            selectedColor: CustomColors.darkBlue,
            confirmText: Text(
                style: const TextStyle(color: CustomColors.darkBlue),
                groupName.value.isEmpty ? '' : 'Zapisz'),
            cancelText: Text(
                style: const TextStyle(color: CustomColors.darkBlue), 'Anuluj'),
            title: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: groupName.value,
                    onChanged: (value) {
                      groupName.value = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Nazwa grupy',
                    ),
                  ),
                ),
              ],
            ),
            height: 280,
            width: min(constraints.maxWidth * 0.8, 200),
            items: availableOptions,
            initialValue: selectedOptions,
            onConfirm: (options) {
              if (groupName.value.isNotEmpty) {
                onConfirm(options, groupName.value);
              }
            });
      },
    );
  }
}
