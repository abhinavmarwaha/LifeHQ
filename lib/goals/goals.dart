import 'package:flutter/material.dart';
import 'package:lifehq/constants/dimensions.dart';
import 'package:lifehq/goals/add_goal_page.dart';
import 'package:lifehq/goals/goal_page.dart';
import 'package:lifehq/goals/models/goal.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';
import 'package:provider/provider.dart';

class Goals extends StatelessWidget {
  const Goals({Key? key}) : super(key: key);

  static const routeName = '/goals';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Consumer<GoalsService>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyBackButton(),
                Text(
                  "Goals",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: provider.goals.map((e) => GoalCard(goal: e)).toList(),
              )),
            ),
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddGoalPage.routeName);
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
                                color: Colors.black,
                                fontSize: Dimensions.ButtonBigText),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  const GoalCard({
    Key? key,
    required this.goal,
  }) : super(key: key);

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => GoalPage(goal: goal)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  goal.title!,
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
