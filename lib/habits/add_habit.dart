import 'package:flutter/material.dart';
import 'package:lifehq/habits/models/habit_model.dart';
import 'package:lifehq/habits/services/habits_provider.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class AddHabit extends StatefulWidget {
  AddHabit({Key? key}) : super(key: key);

  static const routeName = '/add-habit';

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _cue = "";
  String _craving = "";
  String _response = "";
  String _reward = "";
  String _behavior = "";
  int _hour = 0;
  int _min = 0;
  String _location = "";
  String _quantityString = "";
  HabitFreq _freq = HabitFreq.daily;
  bool _bad = false;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          ...[
            "_title",
            "_craving",
            "_response",
            "_reward",
            "_behavior",
            "_location"
          ].map(
            (e) => TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: e
                      .replaceAll("_", "")
                      .replaceAll(e[0], e[0].toUpperCase())),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                return null;
              },
              onChanged: (value) => e = value,
            ),
          ),
          TextButton(
            child: Text(_hour.toString() + ":" + _min.toString()),
            onPressed: () => _selectTime(context),
          ),
          DropdownButton<String>(
            style: TextStyle(color: Colors.white),
            items: HabitFreq.values
                .map<DropdownMenuItem<String>>((HabitFreq freq) {
              return DropdownMenuItem<String>(
                value: freq.toString(),
                child: Text(freq.toShortString()),
              );
            }).toList(),
            onChanged: (val) => _freq = HabitFreqFromString(val ?? ""),
            // value: _freq.toShortString(),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Good'),
                  leading: Radio(
                    value: false,
                    groupValue: _bad,
                    onChanged: (bool? value) {
                      setState(() {
                        _bad = value!;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Bad'),
                  leading: Radio(
                    value: true,
                    groupValue: _bad,
                    onChanged: (bool? value) {
                      setState(() {
                        _bad = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final habit = Habit(
                      title: _title,
                      added: DateTime.now(),
                      cue: _cue,
                      craving: _craving,
                      response: _response,
                      reward: _reward,
                      behavior: _behavior,
                      hour: _hour,
                      min: _min,
                      location: _location,
                      doneAt: [],
                      quantityString: _quantityString,
                      quantity: 0,
                      bad: _bad,
                      freq: _freq);
                  Provider.of<HabitsProvider>(context, listen: false)
                      .saveHabit(habit)
                      .then((value) => Navigator.pop(context));
                }
              },
              child: const Text('Add'),
            ),
          ),
        ]),
      ),
    ));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (picked_s != null)
      setState(() {
        _hour = picked_s.hour;
        _min = picked_s.minute;
      });
  }
}
