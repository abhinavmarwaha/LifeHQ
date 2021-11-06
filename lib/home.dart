import 'package:flutter/material.dart';
import 'package:lifehq/custom_icons.dart';
import 'package:lifehq/goals/goals.dart';
import 'package:lifehq/habits/habits.dart';
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
              HomeCard(
                route: RoutineHome.routeName,
                title: "Routines",
                icon: CustomIcons.routine,
              ),
              Spacer(),
              HomeCard(
                route: Journal.routeName,
                title: "Journal",
                icon: CustomIcons.journal,
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              HomeCard(
                route: Goals.routeName,
                title: "Goals",
                icon: CustomIcons.goal,
              ),
              Spacer(),
              HomeCard(
                route: Knowledge.routeName,
                title: "Knowledge",
                icon: CustomIcons.knowledge,
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          HomeCard(
            route: Habits.routeName,
            title: "Habits",
            icon: Icons.repeat,
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.route,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String route;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 64,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
