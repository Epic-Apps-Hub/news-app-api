import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:clay_containers/clay_containers.dart';

import 'package:flutter/material.dart';
import 'package:newsappapi/api/Manage_Api.dart';
import 'package:newsappapi/widgets/PostBox.dart';
import 'package:newsappapi/widgets/SearchResult.dart';
import 'package:theme_provider/theme_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool issearching = false;
  TextEditingController textController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String keyword = "";
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInLeft(
                animate: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 35),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ThemeProvider.themeOf(context).data.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FadeInRight(
                      animate: true,
                      delay: Duration(milliseconds: 300),
                      child: TextFormField(
                          validator: (val) {
                            if (val.length == 0) {
                              return "Field Can't Be Empty";
                            }
                          },
                          controller: textController,
                          onSaved: (val) {
                            setState(() {
                              keyword = val;
                            });
                          },
                          onTap: () {
                            setState(() {
                              issearching = true;
                            });
                          },
                          style: TextStyle(
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .backgroundColor,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              hintText: "Search Here",
                              suffixIcon: issearching
                                  ? GestureDetector(
                                      child: Icon(Icons.close),
                                      onTap: () {
                                        textController.clear();
                                        setState(() {
                                          keyword = "";
                                        });
                                      },
                                    )
                                  : null,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ThemeProvider.themeOf(context)
                                      .data
                                      .backgroundColor))),
                    ),
                  ),
                )),
            FadeInUp(
              animate: true,
              child: GestureDetector(
                onTap: () {
                  if (!key.currentState.validate()) {
                    return;
                  }
                  key.currentState.save();
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      color: ThemeProvider.themeOf(context).data.cardColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Show Result",
                      style: TextStyle(
                          color: ThemeProvider.themeOf(context)
                              .data
                              .backgroundColor),
                    ),
                  )),
                ),
              ),
            ),
            keyword.length == 0
                ? Spin(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .6,
                      child: Center(
                        child: Image(
                          image: AssetImage(
                            "images/search.png",
                          ),
                          height: 80,
                        ),
                      ),
                    ),
                  )
                : BuildResult()
          ],
        ),
      ),
    );
  }
}
