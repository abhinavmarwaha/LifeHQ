import 'package:flutter/material.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/routine/single_word.dart';
import 'package:provider/provider.dart';

class Rested extends StatelessWidget {
  const Rested({Key? key}) : super(key: key);

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
                Provider.of<RoutineService>(context, listen: false)
                    .goingOnRoutine!
                    .rested = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => SingleWord(
                              title: "What Worked?",
                            )));
              },
            ),
            Choice(
              text: "No",
              onTap: () {
                Provider.of<RoutineService>(context, listen: false)
                    .goingOnRoutine!
                    .rested = 1;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => SingleWord(
                              title: "Whats Wrong?",
                            )));
              },
            ),
            Choice(
              text: "Don't know",
              onTap: () {
                print("Don't know");
              },
            ),
            Choice(
              text: "Maybe",
              onTap: () {
                print("Maybe");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Choice extends StatelessWidget {
  const Choice({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        GestureDetector(
          onTap: onTap as void Function()?,
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
