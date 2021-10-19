import 'package:flutter/material.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/models/task.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/skeleton.dart';

class AddGoalPage extends StatefulWidget {
  AddGoalPage({Key? key}) : super(key: key);

  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  Goal goal = Goal(
      tasks: [],
      added: DateTime.now(),
      deadline: DateTime.now(),
      done: false,
      goalType: 0,
      title: "");

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [
        Expanded(
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              GoalsService.instance.saveGoal(goal);
              Navigator.pop(context);
            },
          ),
          flex: 1,
        ),
        Expanded(
          child: TextField(
            onChanged: (val) => goal.title = val,
          ),
          flex: 1,
        ),
        Expanded(
          child: Column(
              children: goal.tasks
                      // ignore: unnecessary_cast
                      .map((e) => CheckboxListTile(
                          title: TextField(
                            onChanged: (val) => e.text = val,
                          ),
                          value: goal.done,
                          onChanged: (value) => goal.done = value) as Widget)
                      .toList() +
                  [
                    GestureDetector(
                        child: Text("Add"),
                        onTap: () {
                          setState(() {
                            goal.tasks.add(Task(
                                date: DateTime.now(), done: false, text: ""));
                          });
                        }),
                  ]),
        )
      ],
    ));
  }
}
