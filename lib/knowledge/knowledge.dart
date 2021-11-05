import 'package:flutter/material.dart';
import 'package:lifehq/custom_icons.dart';
import 'package:lifehq/knowledge/feeds.dart';
import 'package:lifehq/knowledge/knowledge_bits_folders.dart';
import 'package:lifehq/knowledge/principles_crud.dart';
import 'package:lifehq/knowledge/quotes.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/widgets/back_button.dart';

class Knowledge extends StatelessWidget {
  const Knowledge({Key? key}) : super(key: key);

  static const routeName = '/knowledge';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyBackButton(),
              Text(
                "Knowledge",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _openInfoDialog(context),
                child: Icon(
                  Icons.info_outline,
                  size: 30,
                ),
              )
            ],
          ),
          Row(children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, KnowledgeBitsFolders.project);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          "Project",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, KnowledgeBitsFolders.area);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            "Area",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ]),
          Row(children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, KnowledgeBitsFolders.research);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          "Research",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, KnowledgeBitsFolders.archive);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          "Archive",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 120,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Misc",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Quotes.routeName);
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CustomIcons.left_quote,
                        color: Colors.black,
                        size: 64,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PrinciplesCRUD.routeName);
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CustomIcons.principle,
                        color: Colors.black,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Feeds()));
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.rss_feed,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context, MaterialPageRoute(builder: (ctx) => Feeds()));
          //       },
          //       child: Card(
          //         color: Colors.white,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30)),
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(
          //             Icons.rss_feed,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 6,
          //     ),
          //     Card(
          //       color: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30)),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(
          //           CustomIcons.flash_cards,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 6,
          //     ),
          //     Card(
          //       color: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30)),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(
          //           CustomIcons.reminder,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  void _openInfoDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            child: Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InfoPoint(
                        name: 'Project',
                        text:
                            'a series of tasks linked to a goal, with a deadline.'),
                    SizedBox(
                      height: 12,
                    ),
                    InfoPoint(
                        name: 'Area of responsibility',
                        text:
                            'a sphere of activity with a standard to be maintained over time.'),
                    SizedBox(
                      height: 12,
                    ),
                    InfoPoint(
                        name: 'Resource',
                        text: 'a topic or theme of ongoing interest.'),
                    SizedBox(
                      height: 12,
                    ),
                    InfoPoint(
                        name: 'Archives',
                        text:
                            'inactive items from the other three categories.'),
                  ],
                ))));
  }
}

class InfoPoint extends StatelessWidget {
  const InfoPoint({
    Key? key,
    required this.name,
    required this.text,
  }) : super(key: key);

  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 3,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: Container(),
      ),
      Flexible(
        flex: 6,
        child: Text(
          '"' + text + '"',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ]);
  }
}
