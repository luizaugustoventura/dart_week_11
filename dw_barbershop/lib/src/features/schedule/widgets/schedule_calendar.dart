import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;
  final List<String> workDays;

  const ScheduleCalendar({
    super.key,
    required this.cancelPressed,
    required this.okPressed,
    required this.workDays,
  });

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;
  late final List<int> weekDaysEnabled;

  int convertWeekDay(String weekDay) {
    return switch (weekDay.toLowerCase()) {
      'seg' => DateTime.monday,
      'ter' => DateTime.tuesday,
      'qua' => DateTime.wednesday,
      'qui' => DateTime.thursday,
      'sex' => DateTime.friday,
      'sab' => DateTime.saturday,
      'dom' => DateTime.sunday,
      _ => 0,
    };
  }

  @override
  void initState() {
    weekDaysEnabled = widget.workDays.map(convertWeekDay).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffe6e2e9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: [
        TableCalendar(
          availableGestures: AvailableGestures.none,
          headerStyle: const HeaderStyle(
            titleCentered: true,
          ),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 01, 01),
          lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
          calendarFormat: CalendarFormat.month,
          locale: 'pt_BR',
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          enabledDayPredicate: (day) {
            return weekDaysEnabled.contains(day.weekday);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: ColorConstants.brown,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: ColorConstants.brown.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: widget.cancelPressed,
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.brown,
                  ),
                )),
            TextButton(
                onPressed: () {
                  if (selectedDay == null) {
                    Messages.showError('Por favor, selecione um dia', context);
                    return;
                  }
                  widget.okPressed(selectedDay!);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.brown,
                  ),
                )),
          ],
        )
      ]),
    );
  }
}
