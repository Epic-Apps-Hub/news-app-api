import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:newsappapi/api/Manage_Api.dart';
import 'package:newsappapi/widgets/PostBox.dart';
import 'package:theme_provider/theme_provider.dart';

class FirstPage extends StatefulWidget {
  final ScrollController scrollController;

  const FirstPage({this.scrollController});
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Api_Manager api_manager = Api_Manager();

  Future<bool> isnotConnected() async {
    return await ConnectivityWrapper.instance.isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: api_manager.getNews(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            ////////add no internet condetion
            return ListView.builder(
                itemCount: snapshot.data["articles"].length + 1,
                controller: widget.scrollController,
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
