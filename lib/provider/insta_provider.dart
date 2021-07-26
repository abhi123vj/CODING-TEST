import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:instagram/controller/news_controller.dart';

class InstaProvider extends ChangeNotifier {
  final httpClient = http.Client();
  List<dynamic> feeds = [];
  Future fetchData() async {
    final feedController = Get.put(NewsCntroller());

    try {
      final url =
          "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas";
      final Uri restAPIURL = Uri.parse(url);
     // print("respns1");
      http.Response response = await httpClient.get(restAPIURL);

      final List parseData = await json.decode(response.body.toString());
    ///  print(parseData);

      feeds = parseData;
      feedController.listViewData.clear();
      feedController.listViewData.addAll(feeds);
    } catch (e) {
      print("error Ip $e");
    }
  }

  Future fetchCmnts() async {
    final feedController = Get.put(NewsCntroller());

    try {
      final url = "http://cookbookrecipes.in/test.php";
      final Uri restAPIURL = Uri.parse(url);
     // print("respns1");
      http.Response response = await httpClient.get(restAPIURL);

      final List parseData = await json.decode(response.body.toString());
     // print(parseData);
      feeds = parseData;
      feedController.listViewDataCmnts.clear();
      feedController.listViewDataCmnts.addAll(feeds);
      
    } catch (e) {
      print("error Ip $e");
    }
  }

 
}
