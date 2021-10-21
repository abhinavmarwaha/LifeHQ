import 'package:flutter/material.dart';
import 'package:lifehq/routine/goal_sheet.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class SingleWord extends StatefulWidget {
  const SingleWord({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<SingleWord> createState() => _SingleWordState();
}

class _SingleWordState extends State<SingleWord> {
  String _word = "";

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    _submit(_word, context);
                  },
                  child: Icon(Icons.arrow_forward_ios)),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            onFieldSubmitted: (value) {
              _submit(value, context);
            },
            onChanged: (value) => _word = value,
            cursorColor: Colors.white,
            decoration: InputDecoration(
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
          )
        ],
      ),
    );
  }

  _submit(String value, BuildContext context) {
    Provider.of<RoutineService>(context, listen: false)
        .goingOnRoutine!
        .restedString = value;
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => GoalSheet()));
  }
}
