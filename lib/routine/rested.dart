import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:lifehq/routine/goal_sheet.dart';

class Rested extends StatelessWidget {
  const Rested({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Well Rested?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Choice(
              text: "Yes",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => GoalSheet()));
              },
            ),
            Choice(
              text: "No",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => GoalSheet()));
              },
            ),
            Choice(
              text: "Don't know",
              onTap: () {},
            ),
            Choice(
              text: "Maybe",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Choice extends StatelessWidget {
  const Choice({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
