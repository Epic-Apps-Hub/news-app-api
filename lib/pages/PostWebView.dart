import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:theme_provider/theme_provider.dart';

class DetailScreen extends StatefulWidget {
  final String url;
  DetailScreen({this.url});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebviewScaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: ThemeProvider.themeOf(context).data.cardColor),
          brightness: ThemeProvider.themeOf(context).id == "light"
              ? Brightness.light
              : Brightness.dark,
          automaticallyImplyLeading: true,
          backgroundColor: ThemeProvider.themeOf(context).data.accentColor,
          title: Text(
            "Post Details",
            style:
                TextStyle(color: ThemeProvider.themeOf(context).data.cardColor),
          ),
        ),
        url: widget.url,
        scrollBar: true,
        withZoom: true,
        withLocalStorage: true,
      ),
    );
  }
}
