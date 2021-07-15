import 'package:flutter/material.dart';

class Grateful extends StatefulWidget {
  Grateful({Key key}) : super(key: key);

  @override
  _GratefulState createState() => _GratefulState();
}

class _GratefulState extends State<Grateful> {
  List<String> treasures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Grateful for?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {}, child: Icon(Icons.arrow_forward_ios))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ...treasures
                .asMap()
                .map<int, Widget>(
                  (key, value) => MapEntry(
                    key,
                    Row(
                      children: [
                        SizedBox(
                            width: 82,
                            child: TextFormField(
                              onChanged: (value) => treasures[key] = value,
                            )),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              treasures.removeAt(key);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Icon(Icons.cancel),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .values,
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      treasures.add("");
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Spacer()
              ],
            )
          ],
        )));
  }
}
