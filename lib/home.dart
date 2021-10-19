import 'package:flutter/material.dart';
import 'package:lifehq/custom_icons.dart';
import 'package:lifehq/goals/goals.dart';
import 'package:lifehq/journal/journal.dart';
import 'package:lifehq/routine/routine_home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Spacer(),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => RoutineHome()));
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => Journal()));
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Goals()));
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
          ],
        ),
      )),
    );
  }
}
