import 'package:flutter/material.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/goals/models/task.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:lifehq/widgets/checkbox.dart' as myCheckBox;

class RoutineDetails extends StatelessWidget {
  const RoutineDetails({
    Key? key,
    required this.routine,
    required this.tasks,
  }) : super(key: key);

  final Routine routine;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  routine.quote!,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                routine.feel!.char,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
          SizedBox(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routine.getRestedText()!,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        routine.restedString!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Treasure",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: routine.treasures
                  .map((e) => Text(Constants.BULLET + e!))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tasks",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: tasks
                  .map((e) => Row(
                        children: [
                          myCheckBox.CheckBox(checked: e.done),
                          SizedBox(width: 6),
                          Text(e.text)
                        ],
                      ))
                  .toList(),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Utilities.formatedDate(routine.dateTime)),
              )
            ],
          )
        ],
      ),
    );
  }
}
