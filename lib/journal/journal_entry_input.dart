import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:latlong2/latlong.dart';
import 'package:lifehq/journal/models/journal_entry.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/location/picker.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:provider/provider.dart';

class JournalEntryInput extends StatefulWidget {
  const JournalEntryInput({Key? key}) : super(key: key);

  static const routeName = '/add-entry';

  @override
  _JournalEntryInputState createState() => _JournalEntryInputState();
}

class _JournalEntryInputState extends State<JournalEntryInput> {
  // HtmlEditorController controller = HtmlEditorController();
  quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  // String _bodytext = "";
  String title = "";
  Map? _pickedLocation = {};
  String _displayLocationName = "";
  List<String> selectedTags = [];

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
    return Skeleton(
        child: Consumer<JournalService>(
            builder: (context, journalService, child) => SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        _pickedLocation != null
                            ? Expanded(
                                child: SizedBox(
                                  height: 20,
                                  child: Text(
                                    _displayLocationName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            : Container(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel)),
                      ],
                    ),
                    if (journalService.tags.length != 0)
                      SizedBox(
                        height: 48,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedTags
                                        .contains(journalService.tags[index]))
                                      selectedTags
                                          .remove(journalService.tags[index]);
                                    else
                                      selectedTags
                                          .add(journalService.tags[index]);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: selectedTags.contains(
                                                    journalService.tags[index])
                                                ? Colors.white
                                                : Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          journalService.tags[index],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: selectedTags.contains(
                                                      journalService
                                                          .tags[index])
                                                  ? Colors.white
                                                  : Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                          itemCount: journalService.tags.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(children: [
                      Spacer(),
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
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => title = value,
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 24),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: "Title"),
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
                                          _pickedLocation!["latlng"]?.latitude,
                                      longitude:
                                          _pickedLocation!["latlng"]?.longitude,
                                      locationDisplayName: _displayLocationName,
                                      text: jsonEncode(_controller.document
                                          .toDelta()
                                          .toJson()),
                                      // await controller.getText(),
                                      title: title))
                                  .then((value) => Navigator.pop(context));
                            },
                            child: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // TODO HTML EDITOR NOT WORKING.
                    SizedBox(
                      height: 50,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                            quill.QuillToolbar.basic(controller: _controller),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        child: quill.QuillEditor(
                          scrollController: ScrollController(),
                          scrollable: true,
                          focusNode: _focusNode,
                          autoFocus: false,
                          readOnly: false,
                          placeholder: 'Add content',
                          expands: false,
                          padding: EdgeInsets.zero,
                          controller: _controller,
                          
                        ),
                      ),
                    )
                    // Expanded(
                    //   child: HtmlEditor(
                    //       callbacks: Callbacks(
                    //           onInit: () => controller.setFullScreen()),
                    //       controller: controller,
                    //       htmlEditorOptions: HtmlEditorOptions(
                    //           darkMode: true,
                    //           hint: "body",
                    //           inputType: HtmlInputType.text,
                    //           shouldEnsureVisible: true,
                    //           adjustHeightForKeyboard: true,
                    //           autoAdjustHeight: true),
                    //       htmlToolbarOptions: HtmlToolbarOptions(
                    //           toolbarPosition: ToolbarPosition.belowEditor,
                    //           defaultToolbarButtons: const [
                    //             StyleButtons(),
                    //             FontSettingButtons(fontSizeUnit: false),
                    //             FontButtons(clearAll: false),
                    //             ColorButtons(),
                    //             ListButtons(listStyles: false),
                    //             ParagraphButtons(
                    //                 textDirection: false,
                    //                 lineHeight: false,
                    //                 caseConverter: false),
                    //             InsertButtons(
                    //                 video: true,
                    //                 audio: true,
                    //                 table: true,
                    //                 hr: true,
                    //                 otherFile: true)
                    //           ])),
                    // )
                  ],
                ))));
  }
}
