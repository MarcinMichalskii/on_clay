import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CourtAvailability extends HookWidget {
  const CourtAvailability(
      {super.key,
      required this.dateText,
      required this.hourText,
      required this.timeSpanText});
  final String dateText;
  final String hourText;
  final String timeSpanText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 8),
      child: Column(
          children: [Text(dateText), Text(hourText), Text(timeSpanText)]),
    );
  }
}
