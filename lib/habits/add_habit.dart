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

  Map<String, String> values = {
    "Title": "",
    "Cue": "",
    "Craving": "",
    "Response": "",
    "Reward": "",
    "Behavior": "",
    "Location": "",
  };

  int _hour = 2;
  int _min = 10;
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
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel)),
            SizedBox(
              height: 12,
            ),
            ...values.entries.map(
              (val) => TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: val.key),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
                onChanged: (value) => values[val.key] = value,
              ),
            ),
            TextButton(
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Text(
                      _hour.toString() + ":" + _min.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () => _selectTime(context),
            ),
            DropdownButton<String>(
              style: TextStyle(color: Colors.white),
              hint: Text("Frequency"),
              items: HabitFreq.values
                  .map<DropdownMenuItem<String>>((HabitFreq freq) {
                return DropdownMenuItem<String>(
                  value: freq.toShortString(),
                  child: Text(freq.toShortString()),
                );
              }).toList(),
              onChanged: (val) => setState(() {
                _freq = HabitFreqFromString(val ?? "");
              }),
              value: _freq.toShortString(),
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
                            title: values['Title']!,
                            added: DateTime.now(),
                            cue: values['Cue']!,
                            craving: values['Craving']!,
                            response: values['Response']!,
                            reward: values['Reward']!,
                            behavior: values['Behavior']!,
                            hour: _hour,
                            min: _min,
                            location: values['Location']!,
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
                    child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))))),
          ]),
        ),
      ),
    );
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
