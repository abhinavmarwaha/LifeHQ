import 'package:flutter/material.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/routine/single_word.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class Rested extends StatelessWidget {
  const Rested({
    Key? key,
    required this.title,
  }) : super(key: key);

  static const restedRoute = '/rested';
  static const productiveRoute = '/productive';

  final String title;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
                  .restedProductive = 0;
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
                  .restedProductive = 1;
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
              Provider.of<RoutineService>(context, listen: false)
                  .goingOnRoutine!
                  .restedProductive = 2;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => SingleWord(
                            title: "What is confusing you?",
                          )));
            },
          ),
          Choice(
            text: "Maybe",
            onTap: () {
              Provider.of<RoutineService>(context, listen: false)
                  .goingOnRoutine!
                  .restedProductive = 3;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => SingleWord(
                            title: "How Much?",
                          )));
            },
          ),
        ],
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
