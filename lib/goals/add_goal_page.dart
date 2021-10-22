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
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (val) => goal.title = val,
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: "Goal Title"),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                GoalsService.instance.saveGoal(goal);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Expanded(
          child: Column(
              children: goal.tasks
                      // ignore: unnecessary_cast
                      .map((e) => CheckboxListTile(
                          title: TextField(
                            onChanged: (val) => e.text = val,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: "Task"),
                          ),
                          value: e.done,
                          onChanged: (value) => setState(() {
                                e.done = value;
                              })) as Widget)
                      .toList() +
                  [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          goal.tasks.add(Task(
                              date: DateTime.now(), done: false, text: ""));
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          width: double.infinity,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
        )
      ],
    ));
  }
}
