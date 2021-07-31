import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/controller/bookmark_controller.dart';
import 'package:instagram/controller/news_controller.dart';
import 'package:instagram/provider/insta_provider.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final feedController = Get.put(NewsCntroller());
  final bookMarkController = Get.put(BookMarkController());

  final _iconHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'lib/assets/images/logo.png',
              ),
            )),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
                onTap: () => Get.toNamed("/saved"),
                child: Obx(
                  () => SvgPicture.asset(
                    bookMarkController.feedlist.length < 1
                        ? feedController.bookmrk
                        : feedController.bookmrkfill,
                    height: _iconHeight,
                    color: likecolor,
                  ),
                )),
          ),
        ],
      ),
      body: Container(
        color: bgColor,
        child: Consumer<InstaProvider>(builder: (context, model, _) {
          feedController.display(context);
          return FutureBuilder(
              future: model.fetchData(),
              builder: (context, snapshot) => snapshot.connectionState !=
                      ConnectionState.done
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Vx.cyan100),
                      ),
                    )
                  : model.feeds.length == 0
                      ? Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .1),
                                  child: feedController.displyimag),
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: feedController.listViewData.length <= 30
                              ? feedController.listViewData.length
                              : 30,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, left: 10, right: 10, top: 5),
                              child: Material(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(20),
                                elevation: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: CircleAvatar(
                                                backgroundColor:  feedController
                                                              .listViewData[
                                                          index]['fee_type']=="Free"?Vx.green400:Vx.red400,
                                                foregroundColor: Vx.gray600,
                                                child: feedController
                                                              .listViewData[
                                                          index]['fee_type']=="Free"? Icon(
                                                    FontAwesomeIcons.hospital): Text( feedController
                                                              .listViewData[
                                                          index]['fee']),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      feedController
                                                              .listViewData[
                                                          index]['name'],
                                                      style: GoogleFonts
                                                          .robotoMono(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .headline6,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      feedController
                                                              .listViewData[
                                                          index]['address']+", "+feedController
                                                              .listViewData[
                                                          index]['block_name']+", "+feedController
                                                              .listViewData[
                                                          index]['district_name']+", "+feedController
                                                              .listViewData[
                                                          index]['state_name']+", PIN:"+feedController
                                                              .listViewData[
                                                          index]['pincode'].toString(),
                                                      style: GoogleFonts
                                                          .robotoMono(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText2,
                                                        color: textColor,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: .05,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text("Capacity "+
                                                        feedController
                                                                .listViewData[
                                                            index]['available_capacity'].toString()+" | First "+
                                                        feedController
                                                                .listViewData[
                                                            index]['available_capacity_dose1'].toString()+" | Second "+
                                                        feedController
                                                                .listViewData[
                                                            index]['available_capacity_dose2'].toString(),
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                          color: textColor,
                                                          
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
                                                        textAlign: TextAlign.justify,
                                                      ),
                                              ),
                                            SizedBox(
                                        height: .05,
                                      ),
                                                 Text(
                                                      feedController
                                                              .listViewData[
                                                          index]['vaccine'],
                                                      style: GoogleFonts
                                                          .robotoMono(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .headline6,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: .5,
                                                    )
                                                    ,
                                                       Text(
                                                      feedController
                                                              .listViewData[
                                                          index]['date'],
                                                      style: GoogleFonts
                                                          .robotoMono(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .headline6,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textColor,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
        }),
      ),
    );
  }
}
