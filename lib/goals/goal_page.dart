import 'package:flutter/material.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/services/goals_db.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({
    Key? key,
    required this.goal,
  }) : super(key: key);

  static const routeName = '/goal-details';

  final Goal goal;

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [
        Row(
          children: [
            MyBackButton(),
            Expanded(child: Text(widget.goal.title)),
            GestureDetector(
              onTap: () {
                Provider.of<GoalsService>(context, listen: false)
                    .deleteGoal(widget.goal)
                    .then((value) => Navigator.pop(context));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        ...widget.goal.tasks.map((e) => CheckboxListTile(
              title: Text(e.text),
              onChanged: (bool? value) {
                setState(() {
                  e.done = value;
                });
                GoalsDB.instance.editTask(e);
              },
              value: e.done,
            )),
      ],
    ));
  }
}
