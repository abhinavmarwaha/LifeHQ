// import 'package:flutter/material.dart';
// import 'package:html_editor_enhanced/html_editor.dart';

// class JournalEditor extends StatefulWidget {
//   JournalEditor({Key? key}) : super(key: key);

//   @override
//   _JournalEditorState createState() => _JournalEditorState();
// }

// class _JournalEditorState extends State<JournalEditor> {
//   HtmlEditorController controller = HtmlEditorController();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           HtmlEditor(
//               controller: controller,
//               htmlEditorOptions: HtmlEditorOptions(
//                 darkMode: true,
//                 hint: "",
//               ),
//               htmlToolbarOptions: HtmlToolbarOptions(
//                   toolbarPosition: ToolbarPosition.belowEditor,
//                   defaultToolbarButtons: const [
//                     StyleButtons(),
//                     FontSettingButtons(fontSizeUnit: false),
//                     FontButtons(clearAll: false),
//                     ColorButtons(),
//                     ListButtons(listStyles: false),
//                     ParagraphButtons(
//                         textDirection: false,
//                         lineHeight: false,
//                         caseConverter: false),
//                     InsertButtons(
//                         video: true,
//                         audio: true,
//                         table: true,
//                         hr: true,
//                         otherFile: true)
//                   ])),
//           SizedBox(
//             height: 12,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context, controller.getText());
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Container(
//                 height: 30,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Accept",
//                       style: TextStyle(color: Colors.black, fontSize: 14)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
