import 'package:flutter/material.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/skeleton.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({
    Key? key,
    required this.goal,
  }) : super(key: key);

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
        Text(widget.goal.title!),
        ...widget.goal.tasks.map((e) => CheckboxListTile(
              title: Text(e.text!),
              onChanged: (bool? value) {
                setState(() {
                  e.done = value;
                });
              },
              value: e.done,
            )),
        Container(child: Text("Add Task")),
      ],
    ));
  }
}
