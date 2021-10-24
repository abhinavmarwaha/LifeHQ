import 'package:flutter/material.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/models/task.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/routine/grateful.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class AddGoalPage extends StatefulWidget {
  AddGoalPage({
    Key? key,
    this.inRoutine = false,
  }) : super(key: key);

  static const routeName = '/add-goal';
  static const routineRoute = '/add-goal-routine';
  final bool inRoutine;

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
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
                GoalsService.instance.saveGoal(goal).then((value) {
                  if (widget.inRoutine) {
                    Provider.of<RoutineService>(context)
                        .goingOnRoutine!
                        .morningGoalId = value;
                    Navigator.pushNamed(context, Grateful.displayRoute);
                  } else
                    Navigator.pop(context);
                });
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
                              date: DateTime.now(),
                              done: false,
                              text: "",
                              goalId: 0));
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
