import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/widgets/done_at_card.dart';
import 'package:lifehq/skeleton.dart';

class HabitDetails extends StatelessWidget {
  const HabitDetails({
    Key? key,
    required this.habit,
  }) : super(key: key);

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<NeatCleanCalendarEvent>> _events =
        Map.fromIterable(habit.doneAt,
            key: (e) => e.dateTime,
            value: (e) => [
                  NeatCleanCalendarEvent("",
                      startTime: DateTime(1), endTime: DateTime(1)),
                ]);

    return Skeleton(
        child: Column(
      children: [
        Text(
          habit.title,
          style: TextStyle(
              color: habit.bad ? Colors.red : Colors.green, fontSize: 14),
        ),
        Calendar(
          startOnMonday: true,
          events: _events,
          isExpandable: true,
          eventDoneColor: Colors.green,
          selectedColor: Colors.white,
          todayColor: Colors.black,
          dayBuilder: (BuildContext context, DateTime day) {
            return Column(
              children: [
                Text(
                  day.day.toString(),
                ),
                if (habit.doneAt.where((e) => e.dateTime == day).length > 0)
                  Text(habit.bad ? "X" : "✓")
              ],
            );
          },
          eventListBuilder: (BuildContext context,
              List<NeatCleanCalendarEvent> _selectesdEvents) {
            return DoneAtCard(
                doneAt: habit.doneAt
                    .where((element) =>
                        element.dateTime == _selectesdEvents.first.startTime)
                    .first);
          },
          eventColor: Colors.white,
          expandableDateFormat: 'EEEE, dd/MM/yyyy',
          dayOfWeekStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ],
    ));
  }
}
