import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:newsappapi/pages/SingleCategoryPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme_provider/theme_provider.dart';

class TagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Categories",
                    style: TextStyle(
                        color: ThemeProvider.themeOf(context).data.cardColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .75,
                child: ListView(
                  children: [
                    FadeInRight(
                      animate: true,
                      delay: Duration(microseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CatCard(
                            data: "business",
                          ),
                          CatCard(
                            data: "technology",
                          ),
                        ],
                      ),
                    ),
                    FadeInLeft(
                      delay: Duration(microseconds: 1500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CatCard(
                            data: "general",
                          ),
                          CatCard(
                            data: "health",
                          ),
                        ],
                      ),
                    ),
                    FadeInRight(
                      delay: Duration(microseconds: 2500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CatCard(
                            data: "science",
                          ),
                          CatCard(
                            data: "sports",
                          ),
                        ],
                      ),
                    ),
                    FadeInUp(
                      delay: Duration(microseconds: 3500),
                      animate: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CatCard(
                            data: "entertainment",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CatCard extends StatefulWidget {
  final String data;
  CatCard({this.data});
  @override
  _CatCardState createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: CategoryPage(
                    category: widget.data,
                  )));
        },
        child: Container(
          height: 140,
          width: 160,
          child: Card(
            color: ThemeProvider.themeOf(context).data.cardColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              child: Center(
                child: Text(
                  widget.data,
                  style: TextStyle(
                      color:
                          ThemeProvider.themeOf(context).data.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
