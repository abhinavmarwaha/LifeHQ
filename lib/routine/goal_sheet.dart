import 'package:flutter/material.dart';

class GoalSheet extends StatelessWidget {
  const GoalSheet({Key key}) : super(key: key);

  final String titleOfDay = '"Make Shit"';
  final List<String> tasks = const [
    "10 CP problems",
    "Complete App UI",
    "Call Moms"
  ];
  final String bullet = "\u2022 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleOfDay,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ...tasks.map((e) => Text(bullet + e)),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Spacer(),
                Card(
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
                Spacer(),
              ],
            )
          ],
        )));
  }
}
