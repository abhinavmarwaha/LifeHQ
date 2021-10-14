import 'package:awesome_emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:lifehq/routine/rested.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:provider/provider.dart';

class Feel extends StatefulWidget {
  Feel({Key key}) : super(key: key);

  @override
  _FeelState createState() => _FeelState();
}

class _FeelState extends State<Feel> {
  final List<Emoji> allEmojis = Emoji.all();
  List<Emoji> selectedEmojis = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How do you feel?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  selectedEmojis = allEmojis
                      .where((element) => element.name.contains(value))
                      .toList();
                });
              },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  suffix: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Type"),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 10,
                children: selectedEmojis
                    .map((e) => GestureDetector(
                        onTap: () {
                          Provider.of<RoutineService>(context, listen: false)
                              .goingOnRoutine
                              .feel = e;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) => Rested()));
                        },
                        child: Text(e.char)))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
