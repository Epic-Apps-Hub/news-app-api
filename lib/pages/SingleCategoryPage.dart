import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newsappapi/api/Manage_Api.dart';
import 'package:newsappapi/widgets/PostBox.dart';
import 'package:theme_provider/theme_provider.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  CategoryPage({this.category});
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Api_Manager api_manager = Api_Manager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(
              color: ThemeProvider.themeOf(context).data.cardColor),
          brightness: ThemeProvider.themeOf(context).id == "light"
              ? Brightness.light
              : Brightness.dark,
          backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
          title: Text(
            widget.category,
            style: TextStyle(
              color: ThemeProvider.themeOf(context).data.cardColor,
            ),
          )),
      body: FutureBuilder(
          future: api_manager.getCategory(widget.category),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            ////////add no internet condetion
            return ListView.builder(
                itemCount: snapshot.data["articles"].length + 1,
                itemBuilder: (ctx, index) {
                  if (index == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: Text(
                          "Latest News",
                          style: TextStyle(
                              color: ThemeProvider.themeOf(context)
                                  .data
                                  .cursorColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  var singlePost = snapshot.data["articles"][index - 1];
                  return SinglePostBox(
                    title: singlePost["title"],
                    imgUrl: singlePost["urlToImage"],
                    date: singlePost["publishedAt"],
                    author: singlePost["source"]["name"],
                    postUrl: singlePost["url"],
                    content: singlePost["content"],
                    description: singlePost["description"],
                  );
                });
          }),
    );
  }
}
