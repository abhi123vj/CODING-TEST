import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/constants/colors.dart';
import 'package:instagram/controller/news_controller.dart';
import 'package:instagram/provider/insta_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Comments extends StatelessWidget {
  Comments({Key? key}) : super(key: key);
  final feedController = Get.put(NewsCntroller());
  final _iconHeight = 25.0;

  @override
  Widget build(BuildContext context) {
            feedController.display(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          title: Text(
            "Comments",
            style: GoogleFonts.robotoMono(
              textStyle: Theme.of(context).textTheme.headline6,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontStyle: FontStyle.normal,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                feedController.share,
                height: _iconHeight,
              ),
            ),
          ],
        ),
        body: Container(
            color: bgColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            backgroundColor: Vx.randomPrimaryColor,
                            foregroundColor: Vx.randomOpaqueColor,
                            child: Icon(EvaIcons.people),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Get.parameters['username'] ?? "name",
                              style: GoogleFonts.robotoMono(
                                textStyle:
                                    Theme.of(context).textTheme.headline6,
                                color: textColor,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Text(Get.parameters['title'] ?? "title",
                                style: GoogleFonts.robotoMono(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  color: textColor,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: .1,
                ),
                Expanded(
                  child: Consumer<InstaProvider>(builder: (context, model, _) {
                    return FutureBuilder(
                        future: model.fetchCmnts(),
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
                            itemCount:
                                feedController.listViewDataCmnts.length <= 30
                                    ? feedController.listViewDataCmnts.length
                                    : 30,
                            itemBuilder: (context, int index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CircleAvatar(
                                        backgroundColor: Vx.randomPrimaryColor,
                                        foregroundColor: Vx.randomOpaqueColor,
                                        child: Icon(EvaIcons.people),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            feedController
                                                    .listViewDataCmnts[index]
                                                ['username'],
                                            style: GoogleFonts.robotoMono(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                              color: textColor,
                                              fontStyle: FontStyle.normal,
                                            )),
                                        Text(
                                            feedController
                                                    .listViewDataCmnts[index]
                                                ['comments'],
                                            style: GoogleFonts.robotoMono(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              color: textColor,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }));
                  }),
                ),
              ],
            )));
  }
}
