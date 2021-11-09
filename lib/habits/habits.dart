import 'package:flutter/material.dart';
import 'package:lifehq/constants/dimensions.dart';
import 'package:lifehq/habits/add_habit.dart';
import 'package:lifehq/habits/habit_details.dart';
import 'package:lifehq/habits/models/done_at.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/services/habits_provider.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Habits extends StatelessWidget {
  const Habits({Key? key}) : super(key: key);

  static const routeName = '/habits';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          MyBackButton(),
          Text(
            "Habits",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openInfoDialog(context),
            child: Icon(
              Icons.info_outline,
              size: 30,
            ),
          )
        ],
      ),
      SizedBox(
        height: 24,
      ),
      Expanded(
        child: Consumer<HabitsProvider>(
          builder: (context, value, child) => ListView(
            children: value.habits
                .map((e) =>
                    HabitCard(habit: e, score: value.habitVal[e.habitId]!))
                .toList(),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AddHabit.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.black, fontSize: Dimensions.ButtonBigText),
                ),
              ),
            ),
          ),
        ),
      )
    ]));
  }

  void _openInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          height: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '(1) make it obvious, (2) make it attractive, (3) make it easy, and (4) make it satisfying. \n\n\n The habit stacking formula is: ‘After [CURRENT HABIT], I will [NEW HABIT]. \n\n\n The implementation intention formula is: I will [BEHAVIOR] at [TIME] in [LOCATION].',
                style: TextStyle(color: Colors.black),
              ),
              TextButton(
                  onPressed: () => launch(
                      "https://www.nateliason.com/notes/atomic-habits-james-clear"),
                  child: Text(
                    "Click Me.",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  const HabitCard({
    Key? key,
    required this.habit,
    required this.score,
  }) : super(key: key);

  final Habit habit;
  final int score;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => HabitDetails(
                      habit: habit,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      habit.title,
                      style: TextStyle(
                          color: habit.bad ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      score.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: habit.bad ? Colors.red : Colors.green,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: TextButton(
                    onPressed: () => _openAddDone(context),
                    child: Text("Add Done",
                        style: TextStyle(color: Colors.black))),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openAddDone(BuildContext context) {
    bool done = false;
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              child: StatefulBuilder(builder: (context, setState) {
                return SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          title: Text("Done?"),
                          value: done,
                          onChanged: (val) => setState(() => done = val!)),
                      TextButton(
                          onPressed: () {
                            Provider.of<HabitsProvider>(context, listen: false)
                                .insertDoneAt(
                                    DoneAt(
                                        dateTime: DateTime.now(),
                                        done: done,
                                        habitId: habit.habitId!),
                                    habit)
                                .then((value) => Navigator.pop(context));
                          },
                          child: Text("Add"))
                    ],
                  ),
                );
              }),
            ));
  }
}
