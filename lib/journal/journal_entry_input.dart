import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:latlong2/latlong.dart';
import 'package:lifehq/journal/journal.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/location/picker.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:provider/provider.dart';

class JournalEntryInput extends StatefulWidget {
  const JournalEntryInput({Key? key}) : super(key: key);

  @override
  _JournalEntryInputState createState() => _JournalEntryInputState();
}

class _JournalEntryInputState extends State<JournalEntryInput> {
  HtmlEditorController controller = HtmlEditorController();
  String title = "";
  Map _pickedLocation = {};
  String _displayLocationName = "";
  List<String?> selectedTags = [];

  DateTime _dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2111));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateTime = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, _dateTime.hour, _dateTime.minute);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            selectedTime.hour, selectedTime.minute);
      });
  }

  Future getLocation() async {
    Utilities.showInfoToast("Don't forget to on the GPS!");

    Map? result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return NominatimLocationPicker(
            searchHint: 'Location',
            awaitingForLocation: "Awaiting Location",
          );
        });
    if (result != null) {
      LatLng latLng = result["latlng"];

      final reverseSearchResult = await Nominatim.reverseSearch(
        lat: latLng.latitude,
        lon: latLng.longitude,
        addressDetails: true,
        extraTags: true,
        nameDetails: true,
      );
      setState(() {
        _pickedLocation = result;
        _displayLocationName = reverseSearchResult.displayName;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<JournalService>(
            builder: (context, journalService, child) => SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pickedLocation != null
                        ? SizedBox(
                            height: 20,
                            child: Text(
                              _displayLocationName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Container(),
                    if (journalService.tags!.length != 0)
                      SizedBox(
                        height: 64,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              index = index + 1;
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedTags
                                          .contains(journalService.tags![index]))
                                        selectedTags
                                            .remove(journalService.tags![index]);
                                      else
                                        selectedTags
                                            .add(journalService.tags![index]);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: selectedTags.contains(
                                                      journalService
                                                          .tags![index])
                                                  ? Colors.white
                                                  : Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          journalService.tags![index]!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: selectedTags.contains(
                                                      journalService
                                                          .tags![index])
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                            itemCount: journalService.tags!.length - 1,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    Row(children: [
                      GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Text(Utilities.beautifulDate(_dateTime)
                              .split("at")[0])),
                      Text(" at "),
                      GestureDetector(
                          onTap: () => _selectTime(context),
                          child: Text(Utilities.beautifulDate(_dateTime)
                              .split("at")[1]))
                    ]),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            getLocation();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.navigation),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => title = value,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: "Type"),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              Provider.of<JournalService>(context,
                                      listen: false)
                                  .saveJournalEntry(JournalEntry(
                                      date: _dateTime,
                                      tags: selectedTags,
                                      lastModified: DateTime.now(),
                                      latitude:
                                          _pickedLocation["latlng"]?.latitude,
                                      longitude:
                                          _pickedLocation["latlng"]?.longitude,
                                      locationDisplayName: _displayLocationName,
                                      text: await controller.getText(),
                                      title: title))
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Journal(),
                                      )));
                            },
                            child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: HtmlEditor(
                          controller: controller,
                          htmlEditorOptions: HtmlEditorOptions(
                            darkMode: true,
                            hint: "",
                          ),
                          htmlToolbarOptions: HtmlToolbarOptions(
                              toolbarPosition: ToolbarPosition.belowEditor,
                              defaultToolbarButtons: const [
                                StyleButtons(),
                                FontSettingButtons(fontSizeUnit: false),
                                FontButtons(clearAll: false),
                                ColorButtons(),
                                ListButtons(listStyles: false),
                                ParagraphButtons(
                                    textDirection: false,
                                    lineHeight: false,
                                    caseConverter: false),
                                InsertButtons(
                                    video: true,
                                    audio: true,
                                    table: true,
                                    hr: true,
                                    otherFile: true)
                              ])),
                    )
                  ],
                ))));
  }
}
