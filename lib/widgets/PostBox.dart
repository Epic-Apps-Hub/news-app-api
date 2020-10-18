import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappapi/pages/PostWebView.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:timeago/timeago.dart' as timeago;

class SinglePostBox extends StatelessWidget {
  String title;
  String imgUrl;
//  DateTime date;
  String date;
  String author;
  String postUrl;
  String content;
  String description;

  SinglePostBox({
    this.title,
    this.imgUrl,
    this.date,
    this.author,
    this.postUrl,
    this.content,
    this.description,
  });

  DateTime convert(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return imgUrl != null
        ? FadeInUp(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 310,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ThemeProvider.themeOf(context).data.cardColor),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 10,
                          top: 20,
                          child: Container(
                            height: 270,
                            width: MediaQuery.of(context).size.width * .45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      imgUrl,
                                    ),
                                    fit: BoxFit.cover),
                                color: Colors.black38),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => DetailScreen(
                                                  url: postUrl,
                                                )));
                                  },
                                  child: Container(
                                    height: 34,
                                    width: 84,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Color(0xff1CD3AD)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Show Post",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                          right: 10,
                          top: 280,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .45,
                            height: 10,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.transparent,
                                  Colors.grey.withOpacity(.1)
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                          )),
                      Positioned(
                        child: Container(
                          width: 170,
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .backgroundColor),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 140,
                                child: Text(
                                  description,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.ibmPlexSans(
                                      color: ThemeProvider.themeOf(context)
                                          .data
                                          .backgroundColor
                                          .withOpacity(.9),
                                      fontSize: 17),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 86),
                                child: Container(
                                  width: 90,
                                  child: Divider(
                                    color: ThemeProvider.themeOf(context)
                                        .data
                                        .backgroundColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    timeago.format(convert(date)),
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    author,
                                    style: TextStyle(
                                        color: ThemeProvider.themeOf(context)
                                            .data
                                            .backgroundColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        left: 10,
                        top: 20,
                      )
                    ],
                  )

                  /* Center(
              child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: ThemeProvider.controllerOf(context)
                                        .currentThemeId ==
                                    "light"
                                ? AssetImage("images/dark.jpg")
                                : AssetImage("images/light.jpg"),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              imgUrl,
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black54, Colors.transparent])),
                  ),
                  Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width - 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              timeago.format(convert(date)),
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(blurRadius: 3, color: Colors.grey)
                                  ],
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              author,
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(blurRadius: 3, color: Colors.grey)
                                  ],
                                  fontSize: 14),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeProvider.themeOf(context).data.cursorColor,
                      fontSize: 18),
                ),
              ),
            ],
          )),*/
                  ),
            ),
          )
        : Container();
  }
}
