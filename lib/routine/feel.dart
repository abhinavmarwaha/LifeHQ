import 'package:awesome_emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/routine/rested.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class Feel extends StatefulWidget {
  Feel({Key? key}) : super(key: key);

  static const routeName = '/feel';

  @override
  _FeelState createState() => _FeelState();
}

class _FeelState extends State<Feel> {
  final List<Emoji> allEmojis = Emoji.all();
  List<Emoji> selectedEmojis = [];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
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
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Type"),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 10,
              children: selectedEmojis
                  .map((e) => GestureDetector(
                      onTap: () {
                        Routine routine =
                            Provider.of<RoutineService>(context, listen: false)
                                .goingOnRoutine!;
                        routine.feel = e;
                        if (routine.routineType == 0)
                          Navigator.pushNamed(context, Rested.restedRoute);
                        else
                          Navigator.pushNamed(context, Rested.productiveRoute);
                      },
                      child: Text(e.char)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
