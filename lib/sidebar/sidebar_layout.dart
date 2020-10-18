import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:newsappapi/localization/app_language.dart';
import 'package:newsappapi/localization/app_localizations.dart';
import 'package:newsappapi/pages/SingleCategoryPage.dart';
import 'package:newsappapi/sidebar/sidebar_item.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flag/flag.dart';
import 'package:newsappapi/main.dart';

class SidebarLayout extends StatefulWidget {
  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> with AfterLayoutMixin {
  int selectedIndex = 0;
  LabeledGlobalKey _walletKey = LabeledGlobalKey("walletKey");
  LabeledGlobalKey _restaurantKey = LabeledGlobalKey("restaurantKey");
  LabeledGlobalKey _myCartKey = LabeledGlobalKey("myCardKey");
  LabeledGlobalKey _myProfileKey = LabeledGlobalKey("myProfileKey");

  RenderBox renderBox;
  double startYPosition;

  void onTabTap(int index) {
    setState(() {
      selectedIndex = index;
      switch (selectedIndex) {
        case 0:
          renderBox = _walletKey.currentContext.findRenderObject();
          Navigator.pop(context);
          pageviewController.jumpToPage(0);
          break;
        case 1:
          renderBox = _restaurantKey.currentContext.findRenderObject();
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => CategoryPage(
                        category: "sports",
                      )));
          break;
        case 2:
          renderBox = _myCartKey.currentContext.findRenderObject();
          Navigator.pop(context);
          pageviewController.jumpToPage(1);

          break;
        case 3:
          renderBox = _myProfileKey.currentContext.findRenderObject();
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

          break;
      }

      startYPosition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          width: 90,
          top: 0,
          bottom: 0,
          right: 0,
          child: ClipPath(
            clipper: SidebarClipper(
              (startYPosition == null) ? 0 : startYPosition - 40,
              (startYPosition == null) ? 0 : startYPosition + 80,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Color(0xFF393e46)
                        : Color(0xFFFFFFFF),
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Color(0xFF343941)
                        : Color(0xFFF5F3F3),
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Color(0xFF2E333B)
                        : Color(0xFFE7E7E7),
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Color(0xFF242930)
                        : Color(0xFFDFDEDE),
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Color(0xFF242A31)
                        : Color(0xFFF0F0F0),
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Color(0xFF232A33)
                        : Color(0xFFC7C6C6),
                  ],
                  stops: [0.05, 0.3, 0.5, 0.55, 0.8, 1],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: -25,
          top: 0,
          bottom: 0,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              IconButton(
                icon: Icon(
                  ThemeProvider.controllerOf(context).currentThemeId == "dark"
                      ? Icons.lightbulb
                      : Icons.lightbulb_outline_sharp,
                  color: ThemeProvider.controllerOf(context).currentThemeId ==
                          "dark"
                      ? Colors.white
                      : Colors.black87,
                ),
                onPressed: () {
                  if (ThemeProvider.controllerOf(context).currentThemeId ==
                      "light") {
                    ThemeProvider.controllerOf(context).setTheme("dark");
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        statusBarColor:
                            ThemeProvider.themeOf(context).data.accentColor));
                  } else {
                    ThemeProvider.controllerOf(context).setTheme("light");
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        statusBarColor:
                            ThemeProvider.themeOf(context).data.accentColor));
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              IconButton(
                icon: Icon(Icons.search_rounded),
                onPressed: () {
                  pageviewController.jumpToPage(2);
                  Navigator.pop(context);
                },
                color:
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Colors.white
                        : Colors.black87,
              ),
              SizedBox(
                height: 120,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SidebarItem(
                      key: _walletKey,
                      text: "Home",
                      onTabTap: () {
                        onTabTap(0);
                      },
                      isSelected: selectedIndex == 0,
                    ),
                    SidebarItem(
                      key: _restaurantKey,
                      text: "Football",
                      onTabTap: () {
                        onTabTap(1);
                      },
                      isSelected: selectedIndex == 1,
                    ),
                    SidebarItem(
                      key: _myCartKey,
                      text: "Categories",
                      onTabTap: () {
                        onTabTap(2);
                      },
                      isSelected: selectedIndex == 2,
                    ),
                    SidebarItem(
                      key: _myProfileKey,
                      text: "Language",
                      onTabTap: () {
                        onTabTap(3);
                      },
                      isSelected: selectedIndex == 3,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ],
    );
  }

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
  void afterFirstLayout(BuildContext context) {
    setState(() {
      renderBox = _walletKey.currentContext.findRenderObject();
      startYPosition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }
}

class SidebarClipper extends CustomClipper<Path> {
  final double startYPosition, endYPosition;

  SidebarClipper(this.startYPosition, this.endYPosition);

  @override
  Path getClip(Size size) {
    Path path = Path();

    double width = size.width;
    double height = size.height;

    //up curve
    path.moveTo(width, 0);
    path.quadraticBezierTo(width / 3, 5, width / 3, 70);

    //custom curve
    path.lineTo(width / 3, startYPosition);
    path.quadraticBezierTo(width / 3 - 2, startYPosition + 15, width / 3 - 10,
        startYPosition + 25);
    path.quadraticBezierTo(0, startYPosition + 45, 0, startYPosition + 60);
    path.quadraticBezierTo(
        0, endYPosition - 45, width / 3 - 10, endYPosition - 25);
    path.quadraticBezierTo(
        width / 3 - 2, endYPosition - 15, width / 3, endYPosition);

    //down curve
    path.lineTo(width / 3, height - 70);
    path.quadraticBezierTo(width / 3, height - 5, width, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
