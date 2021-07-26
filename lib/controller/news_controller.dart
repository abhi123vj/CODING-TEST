import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:instagram/constants/colors.dart';

class NewsCntroller extends GetxController {
  var listViewData = [].obs;
    var listViewDataCmnts = [].obs;
  final String likefill = 'lib/assets/images/likefill.svg';
    final String bookmrkfill = 'lib/assets/images/bookmarkfill.svg';

  final String like = 'lib/assets/images/like.svg';
  final String cmnt = 'lib/assets/images/cmnt.svg';
  final String share = 'lib/assets/images/share.svg';
  final String bookmrk = 'lib/assets/images/bookmark.svg';

  Widget displyimag = Container();
  Future display(BuildContext context) async {
    final Widget svg = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
    
        Text(
          "Slow Internet or No internet \nPlese check your Internet Settings.\nTry again!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Zenloop",
            fontSize: 20,
            color: textColor,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );

    final Widget svg2 = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
       
        Text(
          "Nothing to display\nYou are Up to minute",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Zenloop",
            fontSize: 20,
            color: textColor,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );

    try {
      final result = await InternetAddress.lookup('example.com');
      displyimag = svg2;
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      displyimag = svg;
    }
  }
}
