import 'package:flutter/material.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/skeleton.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
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
      ],
    ));
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
                  width: 4,
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
