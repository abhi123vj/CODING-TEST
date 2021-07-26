import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:instagram/models/feed.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class BookMarkController extends GetxController {
  var feedlist = <Feeds>[].obs;
  late File displayImage;
  final String dataBoxName = "bookmarks";

  late Box<Feeds> dataBox;

  Future<void> save(var post) async {
    int flag = 0;
    for (var i = 0; i < feedlist.length; i++) {
      if (feedlist[i].id == post['id']) flag = 1;
    }
    if (flag == 0) {
      try {
        String myString = post['high thumbnail'];
        String rev = myString.split('').reversed.join('');
        final replaced = rev.replaceFirst(RegExp('/'), '_');
        myString = replaced.split('').reversed.join('');
        final Uri restAPIURL = Uri.parse(post['high thumbnail']);
        final response = await http.get(restAPIURL);
        final imageName = path.basename(myString);
        final appDir = await pathProvider.getApplicationDocumentsDirectory();
        final localPath = path.join(appDir.path, imageName);
        final imageFile = File(localPath);
        await imageFile.writeAsBytes(response.bodyBytes);
        displayImage = imageFile;
        Feeds data = Feeds(
            id: post['id'],
            channelname: post['channelname'],
            title: post['title'],
            highthumbnail: post['high thumbnail'],
            localpath: localPath,
            imagename: imageName);
        dataBox.add(data);
        feedlist.add(data);
        print(
            "image name $imageName and local path is $localPath ${dataBox.values.toList()}");
      } catch (e) {
        print("error $e");
      }
    } else
      Get.snackbar("Already Added!", post["title"]);
  }

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);

    Hive.registerAdapter(FeedsAdapter());
    await Hive.openBox<Feeds>(dataBoxName);

    dataBox = Hive.box<Feeds>(dataBoxName);
    feedlist.addAll(dataBox.values.toList());
    super.onInit();
  }

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

  dispimg(String path) {
    var _image = File(path);
    return Container(
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: FileImage(_image), fit: BoxFit.cover)),
    );
  }

  rembook(int index) {
      feedlist.removeAt(index);
      dataBox.deleteAt(index);
  }
}
