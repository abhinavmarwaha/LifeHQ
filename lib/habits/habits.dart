import 'package:flutter/material.dart';
import 'package:lifehq/constants/dimensions.dart';
import 'package:lifehq/habits/add_habit.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/services/habits_provider.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

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
      Expanded(
        child: Consumer<HabitsProvider>(
          builder: (context, value, child) => ListView(
            children: value.habits
                .map((e) => HabitCard(
                      habit: e,
                    ))
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
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [],
                ))));
  }
}

class HabitCard extends StatelessWidget {
  const HabitCard({
    Key? key,
    required this.habit,
  }) : super(key: key);

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
