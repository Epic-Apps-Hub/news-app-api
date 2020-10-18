import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Api_Manager {
  Future getNews() async {
    http.Response res = await http.get(
        //sortBy=published-------https://newsapi.org/v2/everything?q=a&sortBy=publishedAt&apiKey=b15d45a57db54093814bfb61aa1bd7f7
        "https://newsapi.org/v2/top-headlines?category=science&sortBy=published&apiKey=b15d45a57db54093814bfb61aa1bd7f7");

    var body = jsonDecode(res.body);

    return body;
  }

  Future getResults(String keyword) async {
    http.Response res = await http.get(
        "https://newsapi.org/v2/everything?q=$keyword&apiKey=b15d45a57db54093814bfb61aa1bd7f7");

    var body = jsonDecode(res.body);

    return body;
  }

  Future getCategory(String cat) async {
    http.Response res = await http.get(
        "https://newsapi.org/v2/top-headlines?category=$cat&apiKey=b15d45a57db54093814bfb61aa1bd7f7");
    var body = jsonDecode(res.body);

    return body;
  }
}

