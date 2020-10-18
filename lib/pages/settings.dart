import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:newsappapi/localization/app_language.dart';
import 'package:newsappapi/localization/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:share/share.dart';

class SettingsPage extends StatelessWidget {
  void setLanguage(String lngName, BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);

    switch (lngName) {
      case 'English':
        appLanguage.changeLanguage(Locale("en"));
        break;
      case 'Arabic':
        appLanguage.changeLanguage(Locale("ar"));
        break;
      default:
        appLanguage.changeLanguage(Locale("en"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeProvider.themeOf(context).data.backgroundColor,
      child: Column(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate("language"),
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.cardColor,
                  ),
                ),
                leading: Icon(
                  Icons.public,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                onTap: () {
                  showMaterialModalBottomSheet(
                    backgroundColor:
                        ThemeProvider.themeOf(context).data.backgroundColor,
                    expand: false,
                    context: context,
                    builder: (context, scrollController) => Container(
                      height: 170,
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: ListTile(
                              trailing: Container(
                                child: Flag(
                                  "eg",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              onTap: () {
                                setLanguage("Arabic", context);
                              },
                              title: Text(
                                "Arabic",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cursorColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: ListTile(
                              onTap: () {
                                setLanguage("English", context);
                              },
                              trailing: Container(
                                child: Flag(
                                  "us",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              title: Text(
                                "English",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .cursorColor),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate("Theme"),
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.cardColor,
                  ),
                ),
                leading: Icon(
                  Icons.color_lens,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => ThemeDialog(
                            hasDescription: false,
                          ));
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate("rateTheApp"),
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.cardColor,
                  ),
                ),
                leading: Icon(
                  Icons.stars,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                onTap: () {
                  //LaunchReview.launch();
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate("shareTheApp"),
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.cardColor,
                  ),
                ),
                leading: Icon(
                  Icons.share,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                onTap: () {
                  Share.share(
                      'Check out My Portfolio: https://epic-apps-hub.github.io/My_Portfolio/');
                },
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate("privacyPolice"),
                  style: TextStyle(
                    color: ThemeProvider.themeOf(context).data.cardColor,
                  ),
                ),
                leading: Icon(
                  Icons.info,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: ThemeProvider.themeOf(context).data.cardColor,
                ),
                onTap: (){},
              ),
            ],
          )
        ],
      ),
    );
  }
}
