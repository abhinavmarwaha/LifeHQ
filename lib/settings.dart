import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/services/settings_provider.dart';
import 'package:lifehq/skeleton.dart';
import 'package:lifehq/utils/utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  static const routeName = '/settings';

  // Future<void> localAuth(BuildContext context) async {
  //   final localAuth = LocalAuthentication();
  //   final didAuthenticate = await localAuth.authenticate(
  //     localizedReason: 'Please authenticate',
  //     biometricOnly: true,
  //   );
  //   if (didAuthenticate) {
  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final LocalAuthentication _localAuthentication = LocalAuthentication();

    _fingerprintOn(SettingsProvider provider, bool _secMode) async {
      bool didAuthenticate = await _localAuthentication.authenticate(
          localizedReason: "Verify to on the Lock");

      if (didAuthenticate) {
        provider.setLockBool(_secMode);
      }
    }

    return Skeleton(
      child: Consumer<SettingsProvider>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.cancel)),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.horizontal_split,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Zen Reader (Experimental)",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      Spacer(),
                      Switch(
                        activeColor: Colors.black,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.grey,
                        onChanged: (val) {
                          value.setZenBool(val);
                        },
                        value: value.zenBool,
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (!(Platform.isWindows || Platform.isLinux))
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.fingerprint,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("FingerPrint Lock",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        Spacer(),
                        Switch(
                          activeColor: Colors.black,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.grey,
                          onChanged: (val) {
                            _fingerprintOn(value, val);
                            // if (!val) {
                            // screenLock<void>(
                            //   context: context,
                            //   correctString: value.lockString,
                            //   canCancel: true,
                            //   didUnlocked: () => value
                            //       .setLockBool(val, '')
                            //       .then((val) => Navigator.pop(context)),
                            // );
                            // } else {
                            // final tagText = TextEditingController();

                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return StatefulBuilder(
                            //           builder: (context, setState) {
                            //         return Dialog(
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(20.0)),
                            //             child: Container(
                            //                 height: 140,
                            //                 child: Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(12.0),
                            //                     child: Column(
                            //                       children: [
                            //                         TextField(
                            //                           textAlign:
                            //                               TextAlign.center,
                            //                           controller: tagText,
                            //                           maxLength: 5,
                            //                           keyboardType:
                            //                               TextInputType.number,
                            //                           cursorColor: Colors.white,
                            //                           decoration: InputDecoration(
                            //                               border:
                            //                                   InputBorder.none,
                            //                               hintText:
                            //                                   'password (5 digits)'),
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             if (tagText
                            //                                     .text.length ==
                            //                                 5) {
                            //                               screenLock<void>(
                            //                                 context: context,
                            //                                 correctString:
                            //                                     tagText.text,
                            //                                 canCancel: true,
                            //                                 // customizedButtonChild: const Icon(
                            //                                 //   Icons.fingerprint,
                            //                                 // ),
                            //                                 // customizedButtonTap: () async {
                            //                                 //   await localAuth(context);
                            //                                 // },
                            //                                 // didOpened: () async {
                            //                                 //   await localAuth(context);
                            //                                 // },
                            //                                 didUnlocked: () => value
                            //                                     .setLockBool(
                            //                                         val,
                            //                                         tagText
                            //                                             .text)
                            //                                     .then((val) =>
                            //                                         Navigator.pop(
                            //                                             context)),
                            //                               );
                            //                             } else {
                            //                               Utilities.showToast(
                            //                                   "Should be of length 5");
                            //                             }
                            //                           },
                            //                           child: Card(
                            //                               color: Colors.white,
                            //                               child: Padding(
                            //                                 padding:
                            //                                     const EdgeInsets
                            //                                         .all(8.0),
                            //                                 child: Text(
                            //                                   "Ok",
                            //                                   style: TextStyle(
                            //                                       color: Colors
                            //                                           .black),
                            //                                 ),
                            //                               )),
                            //                         )
                            //                       ],
                            //                     ))));
                            //       });
                            //     });
                            // }
                          },
                          value: value.lockBool,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            SettingsCard(
                icon: Icons.bug_report,
                url: StringConstants.FEATUREFORMURL,
                title: "Bug/Feature request"),
            SettingsCard(
                icon: Icons.rate_review,
                url: StringConstants.RATEAPPURL,
                title: "Rate App"),
            SettingsCard(
                icon: Icons.code,
                url: StringConstants.GITHUBREPO,
                title: "Github Repo"),
            SettingsCard(
                icon: Icons.coffee,
                url: StringConstants.COFFEE,
                title: "Buy Me a Coffee"),
            SettingsCard(
                icon: Icons.people,
                url: StringConstants.PATREON,
                title: "Patreon"),
            SettingsCard(
                icon: Icons.message,
                url: StringConstants.DISCORD,
                title: "Discord"),
            SettingsCard(
                icon: Icons.send,
                url: StringConstants.TWITTER,
                title: "Twitter"),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
    required this.url,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String url;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(url);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(title,
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
