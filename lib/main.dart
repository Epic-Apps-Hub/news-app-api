import 'dart:async';

import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappapi/pages/HomePage.dart';
import 'package:newsappapi/pages/searchPage.dart';
import 'package:newsappapi/pages/settings.dart';
import 'package:newsappapi/pages/tagsPage.dart';

import 'package:newsappapi/sidebar/sidebar_layout.dart';
import 'package:provider/provider.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:theme_provider/theme_provider.dart';

import 'localization/app_language.dart';
import 'localization/app_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      loadThemeOnInit: true,
      saveThemesOnChange: true,
      themes: [
        AppTheme(
            id: "dark",
            description: "",
            data: ThemeData(
                backgroundColor: Color(0xff1b262c),
                errorColor: Colors.white,
                cursorColor: Colors.white,
                cardColor: Color(0xFFF7FFF6),
                accentColor: Color(0xff393e46),
                bottomAppBarColor: Color(0xff393e46))),
        AppTheme(
            id: "light",
            data: ThemeData(
              backgroundColor: Colors.white,
              accentColor: Colors.white,
              errorColor: Color(0xfffddb3a),
              bottomAppBarColor: Color(0xFFF7FFF6),
              cursorColor: Colors.black,
              cardColor: Color(0xFF262726),
              textTheme: TextTheme(
                  body1: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
            description: ""),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => ChangeNotifierProvider<AppLanguage>(
              create: (_) => appLanguage,
              child: Consumer<AppLanguage>(builder: (context, model, child) {
                return MaterialApp(
                    title: "Kora OTG",
                    theme: ThemeData(accentColor: Color(0xfffddb3a)),
                    debugShowCheckedModeBanner: false,
                    supportedLocales: [
                      Locale('en', 'US'),
                      Locale('ar', ''),
                    ],
                    locale: model.appLocale,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    home: MyHomePage());
              })),
        ),
      ),
    );
  }
}

final PageController pageviewController = PageController();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AfterLayoutMixin {
  final controller = ScrollController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageviewController,
        onPageChanged: (val) {
          setState(() {
            index = val;
          });
        },
        children: [
          FirstPage(
            scrollController: controller,
          ),
          TagsPage(),
          SearchPage(),
          SettingsPage()
        ],
      ),
      appBar: ScrollAppBar(
          iconTheme: IconThemeData(
              color: ThemeProvider.themeOf(context).data.cardColor),
          brightness: ThemeProvider.themeOf(context).id == "light"
              ? Brightness.light
              : Brightness.dark,
          controller: controller,
          elevation: 10,
          backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
          automaticallyImplyLeading: false,
          //   elevation: 10,
          title: Text(
            AppLocalizations.of(context).translate("Title"),
            style: GoogleFonts.raleway(
                color: ThemeProvider.themeOf(context).data.cursorColor,
                letterSpacing: 2,
                fontSize: 25),
          )),
      backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
      endDrawer: SidebarLayout(),
      //     body: returnBody(),
      bottomNavigationBar: BottomNavigationBar(
        //   controller: controller,
        selectedItemColor: Color(0xFF1cf37f),
        unselectedItemColor: Colors.grey.withOpacity(.9),
        showSelectedLabels: false,
        backgroundColor: ThemeProvider.themeOf(context).data.bottomAppBarColor,
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 22),
        unselectedLabelStyle: TextStyle(fontSize: .1), currentIndex: index,
        onTap: (val) {
          setState(() {
            index = val;
          });
          pageviewController.jumpToPage(val);
        },
        elevation: 10,
        selectedLabelStyle: TextStyle(fontSize: .1),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Iconic.home,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesome.tags,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Iconic.cog,
              ),
              label: ""),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ThemeProvider.themeOf(context).data.accentColor));
    Timer(
      Duration(seconds: 2),
      () async {
        if (await ConnectivityWrapper.instance.isConnected) {
          Flushbar(
            key: scaffoldKey,
            flushbarPosition: FlushbarPosition.TOP,
            message: "You Are Connected",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          )..show(context);
        } else {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            key: scaffoldKey,
            message: "You Are Not Connected",
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          )..show(context);
        }
      },
    );
/*    Flushbar(
      title: "Welcome",
      message:
          "You are currently using : ${ThemeProvider.controllerOf(context).currentThemeId}",
      duration: Duration(seconds: 4),
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      forwardAnimationCurve: Curves.elasticOut,
      mainButton: FlatButton(
        onPressed: () {
          if (ThemeProvider.controllerOf(context).currentThemeId == "light") {
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
        child: Text(
          ThemeProvider.controllerOf(context).currentThemeId == "dark"
              ? "Enable Light Mode"
              : "Enable Dark Mode",
          style: TextStyle(color: Colors.amber),
        ),
      ),
    )..show(context);*/
  }
}
