import 'package:flutter/material.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/routine/grateful.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class GoalSheet extends StatelessWidget {
  const GoalSheet({Key? key}) : super(key: key);

  static const routeName = '/goal-sheet';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Consumer<GoalsService>(
        builder: (context, goals, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                goals.goalTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ...goals.todayTasks
                .map((e) => Text(StringConstants.BULLET + e.text)),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Grateful.routeName);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Consider it done!",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
