import 'package:flutter/material.dart';
import 'package:lifehq/custom_icons.dart';
import 'package:lifehq/goals/goals.dart';
import 'package:lifehq/journal/journal.dart';
import 'package:lifehq/knowledge/knowledge.dart';
import 'package:lifehq/routine/routine_home.dart';
import 'package:lifehq/settings.dart';
import 'package:lifehq/skeleton.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Settings.routeName);
                  },
                  child: Icon(Icons.settings))
            ],
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutineHome.routeName);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      CustomIcons.routine,
                      color: Colors.black,
                      size: 64,
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Journal.routeName);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      CustomIcons.journal,
                      color: Colors.black,
                      size: 64,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Goals.routeName);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      CustomIcons.goal,
                      color: Colors.black,
                      size: 64,
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Knowledge.routeName);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      CustomIcons.knowledge,
                      color: Colors.black,
                      size: 64,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
