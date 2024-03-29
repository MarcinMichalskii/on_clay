import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:on_clay/utils/time_helper.dart';
import 'package:on_clay/UI/colors.dart';

class SelectDateButton extends HookWidget {
  const SelectDateButton(
      {super.key,
      required this.dateText,
      required this.headerText,
      required this.onDateSelected});
  final DateTime dateText;
  final String headerText;
  final void Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context) {
    final onPress = useCallback(() async {
      final value = await showDatePicker(
          context: context,
          initialDate: TimeHelper.getNewerDate(dateText, DateTime.now()),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 14)));

      if (value != null) {
        onDateSelected(value);
      }
    }, [dateText, onDateSelected]);
    return FormButtonUI(
        title: DateFormat('dd.MM.yyyy').format(dateText),
        headerText: headerText,
        onPress: onPress,
        icon: const Icon(Icons.calendar_month, color: Colors.white));
  }
}

class FormButtonUI extends StatelessWidget {
  const FormButtonUI(
      {super.key,
      required this.title,
      required this.headerText,
      required this.onPress,
      required this.icon,
      this.textColor = Colors.white,
      this.hasHeader = true});
  final String title;
  final Icon icon;
  final String headerText;
  final VoidCallback onPress;
  final Color textColor;
  final bool hasHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasHeader) FormContainerHeader(headerText: headerText),
        DecoratedBox(
          decoration: BoxDecoration(
              color: CustomColors.darkBlue,
              borderRadius: BorderRadius.circular(5)),
          child: _FormButtonContent(
              dateText: title,
              onPress: onPress,
              icon: icon,
              textColor: textColor),
        ),
      ],
    );
  }
}

class _FormButtonContent extends StatelessWidget {
  const _FormButtonContent(
      {required this.dateText,
      required this.onPress,
      required this.icon,
      required this.textColor});

  final String dateText;
  final VoidCallback onPress;
  final Icon icon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          onTap: onPress,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(children: [
              Container(margin: const EdgeInsets.only(left: 8), child: icon),
              Flexible(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(dateText,
                        style: TextStyle(color: textColor, fontSize: 15))),
              )
            ]),
          ),
        ));
  }
}

class FormContainerHeader extends StatelessWidget {
  const FormContainerHeader({
    super.key,
    required this.headerText,
  });

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 8, 0, 2),
      child: Text(
        headerText,
        style: const TextStyle(color: CustomColors.darkGray, fontSize: 12),
      ),
    );
  }
}
