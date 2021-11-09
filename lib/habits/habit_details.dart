import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/services/habits_provider.dart';
import 'package:lifehq/habits/widgets/done_at_card.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

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
        Row(
          children: [
            MyBackButton(),
            Text(
              habit.title,
              style: TextStyle(
                  color: habit.bad ? Colors.red : Colors.green, fontSize: 14),
            ),
            Spacer(),
            GestureDetector(
                onTap: () {
                  Provider.of<HabitsProvider>(context, listen: false)
                      .deleteHabit(habit)
                      .then((value) => Navigator.pop(context));
                },
                child: Icon(Icons.delete))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Calendar(
          startOnMonday: true,
          events: _events,
          isExpanded: true,
          eventDoneColor: Colors.green,
          selectedColor: Colors.white,
          todayColor: Colors.black,
          dayBuilder: (BuildContext context, DateTime day) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      day.day.toString(),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    if (habit.doneAt
                            .where((e) =>
                                DateTime(e.dateTime.year, e.dateTime.month,
                                    e.dateTime.day) ==
                                day)
                            .length >
                        0)
                      Text(
                        habit.bad ? "X" : "✓",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: habit.bad ? Colors.red : Colors.green,
                            fontSize: 14),
                      )
                  ],
                ),
              ),
            );
          },
          eventListBuilder: (BuildContext context,
              List<NeatCleanCalendarEvent> _selectesdEvents) {
            if (_selectesdEvents.length == 0) return Container();
            final doneAt = habit.doneAt.where((element) =>
                element.dateTime == _selectesdEvents.first.startTime);

            return doneAt.length > 0
                ? DoneAtCard(doneAt: doneAt.first)
                : Container();
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
