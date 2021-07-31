import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:intl/intl.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:instagram/controller/news_controller.dart';

class InstaProvider extends ChangeNotifier {
  final httpClient = http.Client();
  List<dynamic> feeds = [];
  Future fetchData() async {
    //final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    var today = DateTime.now();
    var fiftyDaysFromNow = today.add(const Duration(days: 1));

    final feedController = Get.put(NewsCntroller());
    feedController.listViewData.clear();

    for (int i = 1; i < 8; i++) {
      try {
        fiftyDaysFromNow = fiftyDaysFromNow.add(const Duration(days: 1));
print(DateFormat('dd-MM-yyyy').format(fiftyDaysFromNow));
        final url =
            "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=298&date=${DateFormat('dd-MM-yyyy').format(fiftyDaysFromNow)}";
        final Uri restAPIURL = Uri.parse(url);
        http.Response response = await httpClient.get(restAPIURL);
        final Map parseData = await json.decode(response.body.toString());
        feeds = parseData['sessions'];
        feedController.listViewData.addAll(feeds);
        print(url);
      } catch (e) {
        print("error Ip $e");
      }
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
