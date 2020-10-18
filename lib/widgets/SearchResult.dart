
import 'package:flutter/material.dart';
import 'package:newsappapi/api/Manage_Api.dart';

import 'package:newsappapi/widgets/PostBox.dart';
import 'package:theme_provider/theme_provider.dart';

class BuildResult extends StatefulWidget {
  final String keyword;
  BuildResult({this.keyword});
  @override
  _BuildResultState createState() => _BuildResultState();
}

class _BuildResultState extends State<BuildResult> {
  Api_Manager api_manager = Api_Manager();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .65,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: api_manager.getResults(widget.keyword),
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
                          "Result",
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