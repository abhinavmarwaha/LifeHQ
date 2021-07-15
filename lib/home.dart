import 'package:flutter/material.dart';
import 'package:lifehq/routine/routine_home.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

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
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.access_alarm,
                        color: Colors.black,
                        size: 64,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.book,
                      color: Colors.black,
                      size: 64,
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
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.done,
                      color: Colors.black,
                      size: 64,
                    ),
                  ),
                ),
                Spacer(),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.repeat,
                      color: Colors.black,
                      size: 64,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.map,
                  color: Colors.black,
                  size: 64,
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
