import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:on_clay/Models/clubs_groups.dart';

class TypeTextAlert extends HookWidget {
  const TypeTextAlert(
      {super.key,
      required this.headerText,
      required this.clubGroups,
      required this.onConfrimTapped});

  final String headerText;
  final List<ClubsGroup> clubGroups;
  final ValueSetter<String> onConfrimTapped;

  @override
  Widget build(BuildContext context) {
    final inputText = useState('');

    return AlertDialog(
      title: Text(headerText),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              inputText.value = value;
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: inputText.value.isEmpty ||
                  clubGroups.any((element) => element.name == inputText.value)
              ? null
              : () {
                  onConfrimTapped(inputText.value);
                  Navigator.of(context).pop(inputText);
                },
          child: Text('Potwierdź'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Anuluj'),
        ),
      ],
    );
  }
}
