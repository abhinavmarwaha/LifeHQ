import 'package:flutter/material.dart';
import 'package:lifehq/constants/dimensions.dart';
import 'package:lifehq/custom_icons.dart';
import 'package:lifehq/knowledge/principles_crud.dart';
import 'package:lifehq/skeleton.dart';

class Knowledge extends StatelessWidget {
  const Knowledge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Knowledge",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          // Row(children: [
          //   Expanded(
          //     flex: 1,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         height: 120,
          //         child: Card(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15)),
          //           color: Colors.white,
          //           child: Center(
          //             child: Text(
          //               "Project",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   Expanded(
          //     flex: 1,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         height: 120,
          //         child: Card(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15)),
          //           color: Colors.white,
          //           child: Center(
          //             child: Text(
          //               "Area",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ]),
          // Row(children: [
          //   Expanded(
          //     flex: 1,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         height: 120,
          //         child: Card(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15)),
          //           color: Colors.white,
          //           child: Center(
          //             child: Text(
          //               "Research",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   Expanded(
          //     flex: 1,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         height: 120,
          //         child: Card(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15)),
          //           color: Colors.white,
          //           child: Center(
          //             child: Text(
          //               "Archive",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ]),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     height: 120,
          //     child: Card(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15)),
          //       color: Colors.white,
          //       child: Center(
          //         child: Text(
          //           "Fun",
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card(
                //   color: Colors.white,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Icon(
                //       CustomIcons.left_quote,
                //       color: Colors.black,
                //       size: 64,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: 32,
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => PrincipleCRUD()));
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
            height: 60,
          ),
          Center(
            child: Text(
              "Under Construction 🚧",
              style:
                  TextStyle(color: Colors.white, fontSize: Dimensions.BigText),
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Card(
          //       color: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30)),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(
          //           Icons.rss_feed,
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
}
