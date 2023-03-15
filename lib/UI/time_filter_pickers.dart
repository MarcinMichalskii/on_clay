import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/selected_filter_providers.dart';
import 'package:on_clay/UI/select_date_button.dart';
import 'package:on_clay/utils/extensions/time_of_day_extension.dart';

class TimeFilterPickers extends HookConsumerWidget {
  const TimeFilterPickers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final selectedStartHour = ref.watch(selectedStartTimeProvider);
    final selectedEndHour = ref.watch(selectedEndTimeProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    final setDate = useCallback((DateTime date) {
      ref.read(selectedDateProvider.notifier).state = date;
    }, []);

    Future<TimeOfDay?> showStartEndPicker(TimeOfDay initialTime) {
      return showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
      );
    }

    final pickStartHour = useCallback(() async {
      final newHour = await showStartEndPicker(selectedStartHour);
      if (newHour != null) {
        ref.read(selectedStartTimeProvider.notifier).state = newHour;
      }
    }, [selectedStartHour]);

    final pickEndHour = useCallback(() async {
      final newHour = await showStartEndPicker(selectedEndHour);
      if (newHour != null) {
        ref.read(selectedEndTimeProvider.notifier).state = newHour;
      }
    }, [selectedEndHour]);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(children: [
            Text(
              'Kiedy i gdzie gramy?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ]),
          Row(
            children: [
              Container(
                  constraints: const BoxConstraints(maxWidth: 140),
                  child: SelectDateButton(
                      dateText: selectedDate,
                      headerText: 'Data',
                      onDateSelected: setDate)),
            ],
          ),
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                child: FormButtonUI(
                    title: selectedStartHour.formattedHoursMinutes,
                    headerText: "Najwcześniej o",
                    onPress: pickStartHour,
                    icon: const Icon(
                      Icons.flight_takeoff_outlined,
                      color: Colors.white,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                constraints: const BoxConstraints(maxWidth: 100),
                child: FormButtonUI(
                    title: selectedEndHour.formattedHoursMinutes,
                    headerText: "Najpóźniej do",
                    onPress: pickEndHour,
                    icon: const Icon(
                      Icons.flight_land,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          FormButtonUI(
              title: "Pokaż gdzie mogę zagrać",
              headerText: "",
              onPress: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
